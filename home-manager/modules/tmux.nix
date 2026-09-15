{pkgs, ...}: {
  dotfiles.tmux = {
    enable = true;
    package = pkgs.tmux-git;
  };
}
