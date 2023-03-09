{pkgs, ...}: {
  programs.rofi = {
    enable = true;
  };

  xdg.configFile.rofi = {
    recursive = true;
    source = ./config;
  };
}
