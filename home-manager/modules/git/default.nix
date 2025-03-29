{unstable-pkgs, ...}: {
  dotfiles.git.enable = true;
  catppuccin.delta.enable = true;

  home.packages = with unstable-pkgs; [
    delta
  ];
}
