{pkgs, ...}: {
  xdg.configFile."picom/picom.conf".text = ''
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

  services.picom = {
    enable = true;
    package = pkgs.picom;

    backend = "xrender";
    shadow = false;
    fade = false;
    vSync = false;

    opacityRules = [
      "100:_NET_WM_STATE@:32a = '_NET_WM_STATE_FULLSCREEN'"
      "0:_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
      "0:_NET_WM_STATE@[0]:32a *= '_NET_WM_STATE_HIDDEN'"
      "0:_NET_WM_STATE@[1]:32a *= '_NET_WM_STATE_HIDDEN'"
      "0:_NET_WM_STATE@[2]:32a *= '_NET_WM_STATE_HIDDEN'"
      "0:_NET_WM_STATE@[3]:32a *= '_NET_WM_STATE_HIDDEN'"
      "0:_NET_WM_STATE@[4]:32a *= '_NET_WM_STATE_HIDDEN'"
      "98:class_g = 'xst-256color'"
      "90:class_g = 'xst-scratch'"
    ];

    settings = {
      unredir-if-possible = true;
      glx-no-stencil = true;
      xrender-sync-fence = true;
    };
  };
}
