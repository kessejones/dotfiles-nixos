{
  pkgs,
  username,
  ...
}: {
  users = {
    users.${username} = {
      uid = 1000;
      home = "/home/${username}";
      initialPassword = "essek";
      isNormalUser = true;
      shell = pkgs.fish;
      extraGroups = ["audio" "docker" "wheel" "networkmanager"];
    };
  };
}
