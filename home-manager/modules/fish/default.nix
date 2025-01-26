{pkgs, ...}: {
  dotfiles.fish = {
    enable = true;
    extra-packages = [
      pkgs.gum
      pkgs.television
      pkgs.zoxide
      pkgs.eza
    ];
  };
}
