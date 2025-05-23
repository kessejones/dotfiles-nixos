{pkgs, ...}: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.libinput.enable = true;

  services.xserver = {
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

      i3.enable = true;
    };

    displayManager = {
      gdm.enable = true;
      #   lightdm = {
      #     enable = true;
      #     greeters.gtk = {
      #       enable = true;
      #
      #       theme = {
      #         name = "catppuccin-mocha-blue-standard";
      #         package = pkgs.catppuccin-gtk.override {
      #           variant = "mocha";
      #           accents = ["blue"];
      #           size = "standard";
      #         };
      #       };
      #       iconTheme = {
      #         name = "Papirus";
      #         package = pkgs.papirus-icon-theme;
      #       };
      #     };
      #     background = "#181825";
      #
      #     extraSeatDefaults = ''
      #       display-setup-script=${pkgs.writeShellScript "lightdm-setup-autorandr" ''
      #         ${pkgs.autorandr}/bin/autorandr -c
      #       ''}
      #     '';
      #   };
    };
  };
}
