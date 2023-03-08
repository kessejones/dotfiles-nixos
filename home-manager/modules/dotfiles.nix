{pkgs, ...}: {
  xdg.configFile.alacritty = {
    recursive = true;
    source = "${pkgs.kesse.dotfiles}/.config/alacritty";
  };

  xdg.dataFile.fonts = {
    recursive = true;
    source = "${pkgs.kesse.dotfiles}/.fonts";
  };
}
