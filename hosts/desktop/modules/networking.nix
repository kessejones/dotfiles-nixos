{...}: {
  networking = {
    hostName = "momon-san";
    nameservers = ["103.86.96.100" "103.86.99.100"];

    firewall = let
      tcpPorts = [22 24800 25565];
      wifiInterface = "wlp0s20f3";
      etherInterface = "eno1";
      networks = [
        "172.18.0.1/24"
        "192.168.0.1/24"
        "10.0.0.1/24"
      ];
    in {
      enable = true;

      interfaces.${wifiInterface}.allowedTCPPorts = tcpPorts;
      interfaces.${etherInterface}.allowedTCPPorts = tcpPorts;

      extraCommands = let
        mkLocalRule = network: ''
          iptables -A nixos-vpn-killswitch -d ${network} -j ACCEPT
        '';

        localRules = builtins.concatStringsSep "\n" (builtins.map (
            n: (mkLocalRule n)
          )
          networks);

        killSwitchRule = ''
          # Flush old firewall rules
          iptables -D OUTPUT -j nixos-vpn-killswitch 2> /dev/null || true
          iptables -F "nixos-vpn-killswitch" 2> /dev/null || true
          iptables -X "nixos-vpn-killswitch" 2> /dev/null || true

          # Create chain
          iptables -N nixos-vpn-killswitch

          # Allow traffic on localhost
          iptables -A nixos-vpn-killswitch -o lo -j ACCEPT

          # Allow lan traffic
          ${localRules}

          # Allow connecition to vpn server
          iptables -A nixos-vpn-killswitch -p udp -m udp --dport 1194 -j ACCEPT

          # Allow connections tunneled over VPN
          iptables -A nixos-vpn-killswitch -o tun0 -j ACCEPT

          # Disallow outgoing traffic by default
          iptables -A nixos-vpn-killswitch -j DROP

          # Enable killswitch
          iptables -A OUTPUT -j nixos-vpn-killswitch
        '';
      in ''
        # Enable killswitch by default
        ${killSwitchRule}
      '';

      extraStopCommands = ''
        iptables -D OUTPUT -j nixos-vpn-killswitch
      '';
    };

    networkmanager.enable = true;
  };

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