{pkgs, ...}: {
  dotfiles.git.enable = true;
  catppuccin.delta.enable = true;

  home.packages = with pkgs; [
    delta
  ];
}
