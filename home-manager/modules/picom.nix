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
    );
  '';

  services.picom = {
    enable = true;
    package = pkgs.picom-git;

    backend = "glx";
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
