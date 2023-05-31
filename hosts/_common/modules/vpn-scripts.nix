{pkgs, ...}: let
  run-with-root = pkgs.writeScriptBin "run-with-root" ''
    #! ${pkgs.runtimeShell}
    die() {
        echo "die: $*"
        exit 1
    }

    if [ "$(id -u)" != 0 ]; then
        exec sudo -E -- "$0" "$@" || die "this script needs to run as root"
    else
        : "$\{SUDO_UID:=0}" "$\{SUDO_GID:=0}"
    fi
  '';

  killswitch-enabled = pkgs.writeScriptBin "killswitch-enabled" ''
    #! ${pkgs.runtimeShell}
    export PATH=$PATH:${pkgs.iptables}/bin:${run-with-root}/bin
    run-with-root
    iptables -C OUTPUT -j nixos-vpn-killswitch &> /dev/null
  '';

  killswitch-status = pkgs.writeScriptBin "killswitch-status" ''
    #! ${pkgs.runtimeShell}
    export PATH=$PATH:${pkgs.iptables}/bin:${killswitch-enabled}/bin:${run-with-root}/bin
    run-with-root
    if killswitch-enabled; then
      echo "Killswitch enabled";
    else
      echo "Killswitch disabled";
    fi
  '';

  killswitch-up = pkgs.writeScriptBin "killswitch-up" ''
    #! ${pkgs.runtimeShell}
    export PATH=$PATH:${pkgs.iptables}/bin:${killswitch-enabled}/bin:${run-with-root}/bin
    run-with-root
    if killswitch-enabled; then
      echo "Killswitch already enabled";
    else
      iptables -A OUTPUT -j nixos-vpn-killswitch
    fi
  '';

  killswitch-down = pkgs.writeScriptBin "killswitch-down" ''
    #! ${pkgs.runtimeShell}
    export PATH=$PATH:${pkgs.iptables}/bin:${killswitch-enabled}/bin:${run-with-root}/bin
    run-with-root
    if killswitch-enabled; then
      iptables -D OUTPUT -j nixos-vpn-killswitch
    else
      echo "Killswitch already disabled";
    fi
  '';

  killswitch-toggle = pkgs.writeScriptBin "killswitch-toggle" ''
    #! ${pkgs.runtimeShell}
    export PATH=$PATH:${pkgs.iptables}/bin:${killswitch-enabled}/bin:${killswitch-up}/bin:${killswitch-down}/bin:${run-with-root}/bin

    run-with-root
    if killswitch-enabled; then
      killswitch-down
    else
      killswitch-up
    fi
  '';

  nordvpn-generate-key = pkgs.writeScriptBin "nordvpn-generate-key" ''
    #!${pkgs.runtimeShell}
    export PATH=$PATH:${pkgs.curl}/bin:${pkgs.jq}/bin

    if [ "$(id -u)" != 0 ]; then
        exec sudo -E -- "$0" "$@" || die "this script needs to run as root"
    else
        : "$\{SUDO_UID:=0}" "$\{SUDO_GID:=0}"
    fi

    if [ -z "$1" ]; then
      printf "Permanent token is required to generate private key"
      exit 1
    fi

    host="api.nordvpn.com"
    auth_token="$(printf "%s" "token:$1" | base64 -w 0)"
    confpath="/root/wireguard"
    credentials="$confpath/credentials.json"
    privkeyfile="$confpath/nordvpn.key"

    mkdir -p $confpath

    curl -s -H "User-Agent: NordApp Linux 3.16.1 Linux 5.4.0-58-generic" \
      "https://$host/v1/users/services/credentials" \
      -H "Content-Type: application/json" \
      -H "Authorization: Basic $auth_token" > $credentials

    err=$(jq .errors.message $credentials)
    if [ "$err" = "null" ]; then
      privkey=$(jq -j ".nordlynx_private_key" $credentials)
      echo $privkey > $privkeyfile
      printf "Key generated successfully"
    else
      printf "Error getting credentials: $err"
      exit 1
    fi
  '';
in {
  environment.systemPackages = [
    killswitch-enabled
    killswitch-status
    killswitch-up
    killswitch-down
    killswitch-toggle

    nordvpn-generate-key
  ];
}
