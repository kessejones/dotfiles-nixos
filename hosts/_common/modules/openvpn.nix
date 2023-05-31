{...}: {
  services.openvpn = {
    servers = {
      nordvpn89 = {
        autoStart = false;
        config = ''
          config /root/openvpn/br89.nordvpn.com.udp.ovpn
          auth-user-pass /root/openvpn/nordvpn.txt
        '';
      };
    };
  };
}
