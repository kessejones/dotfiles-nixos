{pkgs, ...}: {
  programs.bat = {
    enable = true;
    config = {
      theme = "catppuccin";
    };
    themes = {
      catppuccin = builtins.readFile "${pkgs.catppuccin.bat}/Catppuccin-macchiato.tmTheme";
    };
  };
}
