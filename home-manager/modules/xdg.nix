{...}: let
  associations = {
    "default-web-browser" = ["librewolf.desktop"];
    "inode/directory" = ["nemo.desktop"];

    "audio/*" = ["mpv.desktop"];
    "video/*" = ["mpv.desktop"];
    "image/*" = ["pix.desktop"];

    "application/pdf" = ["zathura.desktop"];

    "application/x-torrent" = ["deluge.desktop"];
    "x-scheme-handler/magnet" = ["deluge.desktop"];

    "text/html" = ["librewolf.desktop"];
    "x-scheme-handler/http" = ["librewolf.desktop"];
    "x-scheme-handler/https" = ["librewolf.desktop"];
    "x-scheme-handler/about" = ["librewolf.desktop"];
    "x-scheme-handler/unknown" = ["librewolf.desktop"];
    "x-scheme-handler/terminal" = ["ghostty.desktop"];
    "x-scheme-handler/discord" = ["discord.desktop"];
  };
in {
  xdg.enable = true;
  xdg.userDirs.enable = true;
  xdg.userDirs.setSessionVariables = true;

  xdg.mimeApps.enable = true;
  xdg.mimeApps.associations.added = associations;
  xdg.mimeApps.defaultApplications = associations;

  xdg.mimeApps.associations.removed = {
    "application/pdf" = ["brave.desktop"];
  };
}
