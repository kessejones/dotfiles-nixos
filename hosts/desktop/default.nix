{...}: {
  imports = [
    ./hardware.nix
    ./modules
    ../_common
  ];

  environment.sessionVariables = {
    WEBKIT_DISABLE_COMPOSITING_MODE = 1;
    XCURSOR_SIZE = "20";
    HYPRCURSOR_SIZE = "20";
    GDK_SCALE = 1;
  };

  environment.extraInit = ''
    xset s off -dpms
  '';

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_CTYPE = "pt_BR.UTF-8";
  };

  programs.steam.enable = true;
}
