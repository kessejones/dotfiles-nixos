{pkgs}: {
  xdg.configFile.awesome = {
    recursive = true;
    source = "${pkgs.kesse.dotfiles}/.config/awesome";
  };

  xdg.configFile.fish = {
    recursive = true;
    source = "${pkgs.kesse.dotfiles}/.config/fish";
  };

  xdg.configFile.alacritty = {
    recursive = true;
    source = "${pkgs.kesse.dotfiles}/.config/alacritty";
  };

  xdg.dataFile.fonts = {
    recursive = true;
    source = "${pkgs.kesse.dotfiles}/.fonts";
  };

  home.file.".scripts" = {
    recursive = true;
    source = "${pkgs.kesse.dotfiles}/.scripts";
  };

  home.file.".gitconfig".source = "${pkgs.kesse.dotfiles}/.gitconfig";
}
