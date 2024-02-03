{pkgs, ...}: let
  theme = "catppuccin-mocha";
in {
  programs.bat = {
    enable = true;
    config = {
      inherit theme;
    };
  };

  xdg.configFile."bat/themes/${theme}.tmTheme".text = builtins.readFile "${pkgs.catppuccin.bat}/Catppuccin-mocha.tmTheme";
}
