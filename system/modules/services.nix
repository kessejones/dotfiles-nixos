{pkgs, ...}: {
  services = {
    xserver = {
      enable = true;
      layout = "br";

      dpi = 96;
      libinput.enable = true;

      videoDrivers = ["nvidia"];

      windowManager = {
        awesome = {
          enable = true;
        };
      };

      displayManager = {
        lightdm = {
          enable = true;
          greeters.gtk = {
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
          background = "#181825";

          extraSeatDefaults = ''
            display-setup-script=${pkgs.writeShellScript "lightdm-setup-autorandr" ''
              ${pkgs.autorandr}/bin/autorandr -c
            ''}
          '';
        };
      };
    };

    openssh.enable = true;

    dbus.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    udisks2.enable = true;
  };
}
