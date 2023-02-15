{pkgs, ...}: {
  gtk = {
    enable = true;

    theme = {
      name = "Catppuccin-Mocha-Standard-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        variant = "mocha";
      };
    };

    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    name = "Catppuccin-Mocha-Dark-Cursors";
    package = pkgs.catppuccin-cursors.mochaDark;
    size = 16;
  };
}
