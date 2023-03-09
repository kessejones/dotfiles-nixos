{pkgs, ...}: {
  xdg.configFile.alacritty = {
    recursive = true;
    source = "${pkgs.kesse.dotfiles}/.config/alacritty";
  };
}
