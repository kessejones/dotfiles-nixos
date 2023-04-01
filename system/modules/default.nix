{...}: {
  imports = [
    ./autorandr.nix
    ./boot.nix
    ./external-display.nix
    ./fonts.nix
    ./networking.nix
    ./nix-config.nix
    ./services.nix
    ./system-pkgs.nix
    ./users.nix
    ./virtualisation.nix
  ];
}
