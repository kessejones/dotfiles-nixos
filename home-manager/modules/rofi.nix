{pkgs, ...}: {
  programs.rofi = {
    enable = true;
  };

  xdg.configFile."rofi" = {
    recursive = true;
    source = "${pkgs.kesse.dotfiles}/.config/rofi";
  };
}
