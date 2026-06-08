{
  pkgs,
  lib,
  ...
}: {
  services.picom = {
    enable = true;
    package = pkgs.unstable.picom;
  };

  xdg.configFile."picom/picom.conf".text = lib.mkForce ''
    backend = "xrender";
    fading = false;
    shadow = false;
    vsync = false;
    unredir-if-possible = true;
    xrender-sync-fence = true;

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
      }
    );
  '';
}
