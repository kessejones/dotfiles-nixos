{pkgs, ...}: {
  gtk = {
    enable = true;

    theme = {
      name = "catppuccin-mocha-blue-standard";
      package = pkgs.catppuccin-gtk.override {
        variant = "mocha";
        accents = ["blue"];
        size = "standard";
      };
    };

    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;

    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 20;
  };
}
