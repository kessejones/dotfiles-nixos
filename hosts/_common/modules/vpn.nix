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
in {
  environment.systemPackages = [killswitch-enabled killswitch-status killswitch-up killswitch-down killswitch-toggle];

  services.openvpn = {
    servers = {
      nordvpn89 = {
        autoStart = true;
        config = ''
          config /root/openvpn/br89.nordvpn.com.udp.ovpn
          auth-user-pass /root/openvpn/nordvpn.txt
        '';
      };
    };
  };
}
