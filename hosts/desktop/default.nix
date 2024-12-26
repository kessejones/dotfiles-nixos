{...}: {
  imports = [
    ./hardware.nix
    ./modules
    ../_common
  ];

  environment.sessionVariables = {
    WEBKIT_DISABLE_COMPOSITING_MODE = 1;
  };

  programs.steam.enable = true;
}
