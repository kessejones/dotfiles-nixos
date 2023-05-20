{...}: {
  imports = [
    ./hardware.nix
    ./modules
    ../_common
  ];

  networking = {
    hostName = "ainz-ooal-gown";
  };
}
