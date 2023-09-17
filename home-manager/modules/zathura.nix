{pkgs, ...}: {
  programs.zathura = {
    enable = true;
    extraConfig = ''
      include catppuccin-mocha
    '';
    options = {
      selection-clipboard = "clipboard";
    };
  };

  xdg.configFile."zathura/catppuccin-mocha".text = builtins.readFile "${pkgs.catppuccin.zathura}/src/catppuccin-mocha";
}
