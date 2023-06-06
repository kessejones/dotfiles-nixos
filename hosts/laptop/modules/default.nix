{...}: {
  imports = [
    ./autorandr.nix
    ./boot.nix
    ./networking.nix
    ./external-display.nix
    ./wireguard.nix
  ];
}
