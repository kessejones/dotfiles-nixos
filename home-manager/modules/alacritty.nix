{...}: {
  catppuccin.enable = true;
  programs.alacritty = {
    enable = true;

    settings = let
      family = "JetBrainsMono Nerd Font";
    in {
      font = {
        size = 10;
        normal = {
          inherit family;
          style = "Regular";
        };
        bold = {
          inherit family;
          style = "Bold";
        };
        bold_italic = {
          inherit family;
          style = "Bold Italic";
        };
        italic = {
          inherit family;
          style = "Italic";
        };
        offset = {
          x = 0;
          y = 0;
        };
        glyph_offset = {
          x = 0;
          y = 0;
        };
      };

      window = {
        # opacity = 0.9;
        padding = {
          x = 5;
          y = 5;
        };
      };

      scrolling = {
        history = 10000;
        multiplier = 10;
      };

      general.live_config_reload = true;

      keyboard.bindings = [
        {
          key = "N";
          mods = "Control|Shift";
          action = "SpawnNewInstance";
        }
        {
          key = "C";
          mods = "Control|Shift";
          action = "Copy";
        }
        {
          key = "V";
          mods = "Control|Shift";
          action = "Paste";
        }
      ];
    };
  };
}
