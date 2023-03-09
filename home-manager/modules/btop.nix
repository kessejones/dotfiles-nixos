{pkgs, ...}: {
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "catppuccin_mocha.theme";
      vim_keys = true;
    };
  };

  xdg.configFile."btop/themes/catppuccin_mocha.theme".text = builtins.readFile "${pkgs.catppuccin.btop}/catppuccin_mocha.theme";
}
