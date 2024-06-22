{...}: {
  programs.mpv = {
    enable = true;
    catppuccin.enable = true;
    config = {
      alang = "jpn,eng,por";
      slang = "por,jpn,eng";
      osd-on-seek = "no";
    };
    bindings = {
      WHEEL_UP = "seek 5";
      WHEEL_DOWN = "seek -5";
      "Shift+WHEEL_UP" = "seek 10";
      "Shift+WHEEL_DOWN" = "seek -10";
      "Ctrl+WHEEL_UP" = "add video-zoom 0.1";
      "Ctrl+WHEEL_DOWN" = "add video-zoom -0.1";
    };
  };
}
