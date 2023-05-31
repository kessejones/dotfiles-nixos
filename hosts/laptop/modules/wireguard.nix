{...}: {
  networking.wg-quick.interfaces.wg0 = let
    endpoint = "185.153.176.165";
  in {
    address = ["10.5.0.3/24"];
    privateKeyFile = "/root/wireguard/nordvpn.key";
    listenPort = 51820;

    peers = [
      {
        publicKey = "ObOAEerHpiFeJaqUbs59yihD4JbLqlC6cQn01guu3UU=";
        allowedIPs = ["0.0.0.0/0" "::/0"];
        endpoint = "${endpoint}:51820";
        persistentKeepalive = 25;
      }
    ];
  };
}
