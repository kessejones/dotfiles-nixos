{pkgs, ...}: {
  programs.kitty = {
    enable = true;

    theme = "Catppuccin-Mocha";
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 10.0;
    };

    extraConfig = ''
      #background #1E1E2F
      active_tab_background   #89b4fa
    '';

    settings = {
      window_padding_width = 2;
      disable_ligatures = "never";

      cursor_shape = "block";
      cursor_blink_interval = 0;
      cursor_stop_blinking_after = 0;

      # background_opacity = "0.9";
      draw_minimal_borders = "yes";
      dynamic_background_opacity = "yes";
      sync_to_monitor = "no";

      hide_window_decorations = "titlebar-only";
      confirm_os_window_close = 0;

      enabled_layouts = "splits,stack";
      tab_bar_style = "separator";
      tab_separator = ''""'';
      tab_title_template = ''" {fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{fmt.fg.tab}{index}:{tab.active_exe} "'';
      tab_title_max_length = "20";

      shell_integration = "disabled";
      #shell = "tmux -u new-session -A -s main";

      kitty_mod = "ctrl+shift";
    };

    keybindings = {
      "ctrl+a>r" = "load_config_file";

      "0x1b" = "escape";
      "$kitty_mod+c" = "copy_to_clipboard";
      "$kitty_mod+v" = "paste_from_clipboard";

      "ctrl+a>n" = "next_tab";
      "ctrl+a>p" = "previous_tab";
      "ctrl+a>q" = "close_tab";
      "ctrl+a>t" = "launch --type=tab $SHELL";
      "ctrl+a>'" = "launch --location=hsplit $SHELL";
      "ctrl+a>\\" = "launch --location=vsplit $SHELL";

      "ctrl+a>shift+k" = "move_window top";
      "ctrl+a>shift+j" = "move_window down";
      "ctrl+a>shift+h" = "move_window left";
      "ctrl+a>shift+l" = "move_window right";

      "ctrl+a>h" = "neighboring_window left";
      "ctrl+a>l" = "neighboring_window right";
      "ctrl+a>k" = "neighboring_window top";
      "ctrl+a>j" = "neighboring_window down";

      "ctrl+a>," = "set_tab_title";
      "ctrl+a>z" = "toggle_layout stack";
      "ctrl+a>e" = "launch --type=overlay fish $EDITOR";

      "ctrl+a>[" = "set_background_opacity 0.9";
      "ctrl+a>]" = "set_background_opacity 1";

      "$kitty_mod+k" = "scroll_line_up";
      "$kitty_mod+j" = "scroll_line_down";

      "ctrl+a>ctrl+k" = "change_font_size all +1.0";
      "ctrl+a>ctrl+j" = "change_font_size all -1.0";
      "ctrl+a>ctrl+," = "change_font_size all 0";
    };

    package = pkgs.kitty;
  };
}
