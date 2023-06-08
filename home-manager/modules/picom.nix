{...}: {
  services.picom = {
    enable = true;
    backend = "glx";

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
    };
  };
}
