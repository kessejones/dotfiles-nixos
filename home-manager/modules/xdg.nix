{...}: {
  xdg.enable = true;
  xdg.userDirs.enable = true;
  xdg.userDirs.setSessionVariables = true;

  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "inode/directory" = "nemo.desktop";

    "video/*" = "mpv.desktop";
    "image/*" = "pix.desktop";

    "application/pdf" = "zathura.desktop";

    "application/x-torrent" = "deluge.desktop";
    "x-scheme-handler/magnet" = "deluge.desktop";

    "text/html" = "librewolf.desktop";
    "x-scheme-handler/http" = "librewolf.desktop";
    "x-scheme-handler/https" = "librewolf.desktop";
    "x-scheme-handler/about" = "librewolf.desktop";
    "x-scheme-handler/unknown" = "librewolf.desktop";
    "x-scheme-handler/terminal" = "ghostty.desktop";
  };
}
