{pkgs, ...}: {
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "catppuccin_mocha.theme";
    };
  };

  xdg.configFile."btop/themes/catppuccin_mocha.theme".text = builtins.readFile "${pkgs.catppuccin.btop}/catppuccin_mocha.theme";
}
