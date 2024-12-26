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
      shell = unstable-pkgs.fish;
      ignoreShellProgramCheck = true;
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
