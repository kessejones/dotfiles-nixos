{...}: {
  programs.mpv = {
    enable = true;
    config = {
      alang = "jpn,eng,por";
      slang = "por,jpn,eng";
      osd-on-seek = "no";
    };
  };
}
