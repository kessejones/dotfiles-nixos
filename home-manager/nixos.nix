{
  config,
  pkgs,
  lib,
  username,
  ...
}: {
  imports = [
    ./modules
  ];

  home = {
    inherit username;

    homeDirectory = "/home/${username}";
    stateVersion = "22.11";
  };

  xdg.enable = true;
  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
  programs.go.enable = true;
}
