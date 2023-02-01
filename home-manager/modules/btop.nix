{pkgs, ...}: {
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "catppuccin_mocha.theme";
    };
  };

  xdg.configFile."btop/themes/catppuccin_mocha.theme" = {
    source = "${pkgs.customBtop.catppuccin}/catppuccin_mocha.theme";
  };
}
