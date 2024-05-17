{pkgs, ...}: {
  services = {
    libinput.enable = true;
    xserver = {
      enable = true;
      xkb.layout = "br";

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
              name = "Catppuccin-Mocha-Standard-Blue-Dark";
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
      jack.enable = true;

      extraConfig.pipewire-pulse = {
        "remove-capture-dont-move" = {
          "pulse.rules" = [
            {
              actions = {
                quirks = [
                  "remove-capture-dont-move"
                ];
              };
              matches = [
                {
                  "application.process.binary" = "firefox";
                }
              ];
            }
          ];
        };
      };
    };

    udisks2.enable = true;
    blueman.enable = true;
  };
}
