{pkgs, lib, ...}: {
  imports = [
    ./dotfiles.nix
    ./gtk.nix
    ./btop.nix
    ./neovim.nix
    ./kitty.nix
    ./discord.nix
    ./bat.nix
    ./firefox.nix
    ./pkgs.nix
  ];
}