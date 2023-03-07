{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./dotfiles.nix
    ./gtk.nix
    ./btop.nix
    ./neovim.nix
    ./kitty.nix
    ./discord.nix
    ./bat.nix
    ./firefox.nix
    ./picom.nix
    ./rofi.nix
    ./autorandr.nix
    ./zathura.nix
    ./pkgs.nix
  ];
}
