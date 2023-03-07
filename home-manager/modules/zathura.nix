{
  pkgs,
  lib,
  ...
}: {
  programs.zathura = {
    enable = true;
    options = {
      include = "catppuccin-mocha";
    };
  };

  xdg.configFile."zathura/catppuccin-mocha".text = builtins.readFile "${pkgs.catppuccin.zathura}/src/catppuccin-mocha";
}
