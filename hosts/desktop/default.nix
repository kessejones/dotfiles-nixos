{
  config,
  pkgs,
  lib,
  username,
  ...
}: {
  imports = [
    ./hardware.nix
    ./modules
    ../_common
  ];
}
