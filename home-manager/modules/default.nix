{
  pkgs,
  lib,
  ...
}: {
  imports = [
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
    ./tmux.nix
    ./mpv.nix
    ./awesomewm.nix
    ./alacritty.nix
    ./git
    ./fish
    ./pkgs.nix
  ];
}
