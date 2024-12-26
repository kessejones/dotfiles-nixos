{pkgs, ...}: {
  dotfiles.git.enable = true;
  home.packages = with pkgs; [
    delta
  ];
}
