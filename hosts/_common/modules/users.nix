{
  pkgs,
  username,
  ...
}: {
  users = {
    groups.${username} = {};

    users.${username} = {
      uid = 1000;
      home = "/home/${username}";
      initialPassword = "essek";
      isNormalUser = true;
      shell = pkgs.unstable.fish;
      ignoreShellProgramCheck = true;
      extraGroups = [
        username
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
