{pkgs, ...}: {
  programs.alacritty = {
    enable = true;

    settings = let
      family = "JetBrainsMono Nerd Font Mono";
    in {
      env.TERM = "tmux-256color";

      font = {
        size = 12;
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
        opacity = 0.9;
        padding = {
          x = 5;
          y = 5;
        };
      };

      scrolling = {
        history = 10000;
        multiplier = 10;
      };

      draw_bold_text_with_bright_colors = true;

      selection = {
        semantic_escape_chars = '',│`|:"\'\' ()[]{}<>'';
        save_to_clipboard = true;
      };

      live_config_release = true;

      shell = {
        program = "tmux";
        args = [
          "-u"
          "new-session"
          "-A"
          "main"
        ];
      };

      key_bindings = [
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
