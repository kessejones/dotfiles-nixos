{pkgs, ...}: {
  services.picom = {
    enable = true;
    backend = "glx";
    package = pkgs.picom-git;

    shadow = false;
    shadowOpacity = 0.3;

    fade = true;
    fadeDelta = 1;
    fadeSteps = [
      0.01
      0.01
    ];

    settings = {
      detect-transient = true;
      detect-client-loader = false;

      no-fading-openclose = true;

      transition-length = 300;
      transition-pow-x = 0.1;
      transition-pow-y = 0.1;
      transition-pow-w = 0.1;
      transition-pow-h = 0.1;
      size-transition = true;

      # animations = true;
      # # auto, none, fly-in, zoom, slide-down, slide-up, slide-left, slide-right, slide-in, slide-out
      # animation-for-transient-window = "slide-down";
      # animation-for-open-window = "none";
      # animation-for-unmap-window = "none";
      # animation-stiffness = 300.0;
      # animation-window_mass = 1.0;
      # animation-dampening = 26;
      # animation-delta = 10;
      # animation-force_steps = false;
      # animation-clamping = true;
    };
  };
}
