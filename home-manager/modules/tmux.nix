{pkgs, ...}: {
  dotfiles.tmux = {
    enable = true;
    package = pkgs.unstable.tmux;
  };
}
