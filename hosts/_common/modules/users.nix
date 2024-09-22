{
  unstable-pkgs,
  username,
  ...
}: {
  users = {
    users.${username} = {
      uid = 1000;
      home = "/home/${username}";
      initialPassword = "essek";
      isNormalUser = true;
      shell = unstable-pkgs.nushell;
      extraGroups = [
        "audio"
        "docker"
        "wheel"
        "networkmanager"
        "nordvpn"
        "plugdev"
      ];
    };
  };
}
