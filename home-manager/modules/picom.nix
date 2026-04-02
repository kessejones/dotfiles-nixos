{
  lib,
  unstable-pkgs,
  ...
}: {
  services.picom = {
    enable = true;
    package = unstable-pkgs.picom;
  };

  xdg.configFile."picom/picom.conf".text = lib.mkForce ''
    backend = "glx";
    fading = false;
    shadow = false;
    vsync = false;
    transparent-clipping = true;

    rules = (
      {
        match = "!fullscreen && (window_type != 'dock' && window_type != 'tooltip' && window_type != 'popup_menu' && window_type != 'utility')";
        animations = ({
          triggers = ["geometry"];
          preset = "geometry-change";
          duration = 0.2;
        });
      },
      {
        match = "!fullscreen";
        shadow = true;
        shadow-offset-x = -15;
        shadow-offset-y = -15;
        shadow-offset-z = -15;
        shadow-opacity = 0.5;
        shadow-radius = 15;
      },
      {
        match = "_NET_WM_STATE@[*] = '_NET_WM_STATE_HIDDEN'";
        opacity = 0;
      }
    );
  '';
}
