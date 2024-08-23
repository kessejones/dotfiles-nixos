{...}: {
  imports = [
    ./hardware.nix
    ./modules
    ../_common
  ];

  environment.sessionVariables = rec {
    NIX_PROFILE_LIB = "$HOME/.nix-profile/lib";
    USER_LIB = "$HOME/.local/lib";
    LD_LIBRARY_PATH = [
      NIX_PROFILE_LIB
      USER_LIB
    ];
    WEBKIT_DISABLE_COMPOSITING_MODE = 1;
  };

  programs.steam.enable = true;
}
