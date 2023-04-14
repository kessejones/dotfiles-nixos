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
    ./zathura.nix
    ./tmux.nix
    ./mpv.nix
    ./awesomewm.nix
    ./alacritty.nix
    ./ncmpcpp.nix
    ./mpd.nix
    ./git
    ./fish
    ./rofi
    ./pkgs.nix
  ];
}
