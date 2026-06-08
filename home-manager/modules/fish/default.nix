{pkgs, ...}: {
  dotfiles.fish = {
    enable = true;
    package = pkgs.unstable.fish;
    extra-packages = with pkgs.unstable; [
      gum
      eza
      skim
    ];
  };
}
