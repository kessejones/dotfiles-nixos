{pkgs, ...}: {
  services = {
    xserver = {
      enable = true;
      layout = "br";

      libinput.enable = true;

      videoDrivers = ["nvidia"];

      windowManager = {
        awesome = {
          enable = true;
          package = pkgs.awesome-git;

          luaModules = with pkgs.luaPackages; [
            luarocks
          ];
        };
      };

      displayManager = {
        lightdm = {
          enable = true;
          greeters.gtk = {
            enable = true;

            theme = {
              name = "Catppuccin-Mocha-Standard-Blue-dark";
              package = pkgs.catppuccin-gtk.override {
                variant = "mocha";
                accents = ["blue"];
                size = "standard";
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
    blueman.enable = true;
  };
}
