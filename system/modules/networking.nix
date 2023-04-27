{...}: {
  networking = {
    firewall = let
      tcp_ports = [22 25565];
      wifi_dev = "wlp2s0";
      ether_dev = "enp3s0f1";
      networks = [
        "192.168.0.1/24"
        "10.0.0.1/24"
      ];

      vpn_servers = [
        "193.19.205.209"
        "185.153.176.17"
        "185.153.176.64"
        "185.153.176.183"
        "185.153.176.235"
      ];

      mkVpnRule = ip: interface: ''
        iptables -A OUTPUT -j ACCEPT -d ${ip} -o ${interface} -p udp -m udp --dport 1194
        iptables -A INPUT -j ACCEPT -s ${ip} -i ${interface} -p udp -m udp --sport 1194
      '';

      mkLocalRule = ip: interface: ''
        iptables -A INPUT --src ${ip} -j ACCEPT -i ${interface}
        iptables -A OUTPUT -d ${ip} -j ACCEPT -o ${interface}
      '';
    in {
      enable = true;

      interfaces.${wifi_dev}.allowedTCPPorts = tcp_ports;
      interfaces.${ether_dev}.allowedTCPPorts = tcp_ports;

      extraCommands = let
        local_rules = builtins.concatStringsSep "\n" (builtins.map (n: ''
            ${mkLocalRule n wifi_dev}
            ${mkLocalRule n ether_dev}
          '')
          networks);

        vpn_rules = builtins.concatStringsSep "\n" (builtins.map (ip: ''
            ${mkVpnRule ip wifi_dev}
            ${mkVpnRule ip ether_dev}
          '')
          vpn_servers);
      in ''
        iptables -P OUTPUT DROP

        iptables -A INPUT -j ACCEPT -i lo
        iptables -A OUTPUT -j ACCEPT -o lo

        ${local_rules}

        ${vpn_rules}

        iptables -A INPUT -j ACCEPT -i tun0
        iptables -A OUTPUT -j ACCEPT -o tun0
      '';
      extraStopCommands = ''
        iptables -P INPUT ACCEPT
      '';
    };

    hostName = "ainz-ooal-gown";
    networkmanager.enable = true;
  };
}
