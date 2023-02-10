{...}: {
  services.picom = {
    enable = true;
    backend = "glx";

    shadow = false;
    shadowOpacity = 0.3;

    fade = false;
    fadeDelta = 4;
  };
}
