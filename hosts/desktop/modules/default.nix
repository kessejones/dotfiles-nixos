{...}: {
  imports = [
    ./autorandr.nix
    ./boot.nix
    ./networking.nix
    ./wireguard.nix
    ./services.nix
    ./hyprland.nix
  ];
}
