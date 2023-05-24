{pkgs, ...}: let
  killswitch-enabled = pkgs.writeScriptBin "killswitch-enabled" ''
    #! ${pkgs.runtimeShell}
    export PATH=${pkgs.iptables}/bin
    iptables -C OUTPUT -j nixos-vpn-killswitch &> /dev/null
  '';
  killswitch-up = pkgs.writeScriptBin "killswitch-up" ''
    #! ${pkgs.runtimeShell}
    export PATH=${pkgs.iptables}/bin:${killswitch-enabled}/bin
    if killswitch-enabled; then
      echo "Killswitch already enabled";
    else
      iptables -A OUTPUT -j nixos-vpn-killswitch
    fi
  '';
  killswitch-down = pkgs.writeScriptBin "killswitch-down" ''
    #! ${pkgs.runtimeShell}
    export PATH=${pkgs.iptables}/bin:${killswitch-enabled}/bin
    if killswitch-enabled; then
      iptables -D OUTPUT -j nixos-vpn-killswitch
    else
      echo "Killswitch already disabled";
    fi
  '';
  killswitch-toggle = pkgs.writeScriptBin "killswitch-toggle" ''
    #! ${pkgs.runtimeShell}
    export PATH=${pkgs.iptables}/bin:${killswitch-enabled}/bin:${killswitch-up}/bin:${killswitch-down}/bin
    if killswitch-enabled; then
      killswitch-down
    else
      killswitch-up
    fi
  '';
in {
  environment.systemPackages = [killswitch-enabled killswitch-up killswitch-down killswitch-toggle];

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
