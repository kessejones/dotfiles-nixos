{pkgs}: {
  programs.bat = {
    enable = true;
    config = {theme = "catppuccin";};
    themes = {
      catppuccin =
        builtins.readFile
        (pkgs.customBat.catppuccin + "/Catppuccin-macchiato.tmTheme");
    };
  };
}
