{unstable-pkgs, ...}: {
  dotfiles.fish = {
    enable = true;
    package = unstable-pkgs.fish;
    extra-packages = [
      unstable-pkgs.gum
      unstable-pkgs.eza
    ];
  };
}
