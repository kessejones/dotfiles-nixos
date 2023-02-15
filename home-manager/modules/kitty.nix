{pkgs, ...}: {
  programs.kitty = {
    enable = true;

    theme = "Catppuccin-Mocha";
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };

    extraConfig = ''
      background #1E1E2F
    '';

    settings = {
      window_padding_width = 2;
      disable_ligatures = "never";

      cursor_shape = "block";
      cursor_blink_interval = 0;
      cursor_stop_blinking_after = 0;

      background_opacity = "0.9";
      draw_minimal_borders = "yes";
      sync_to_monitor = "no";

      hide_window_decorations = "titlebar-only";
      confirm_os_window_close = 0;

      tab_bar_style = "powerline";
      tab_title_template = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{index}:{tab.active_exe}";
      tab_title_max_length = 20;
      enabled_layouts = "splits,stack";

      shell_integration = "disabled";
      shell = "tmux -u new-session -A -s main";

      kitty_mod = "ctrl+shift";
    };

    keybindings = {
      "ctrl+shift+r" = "load_config_file";

      "0x1b" = "escape";
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";

      "ctrl+a>n" = "next_tab";
      "ctrl+a>p" = "previous_tab";
      "ctrl+a>q" = "close_tab";
      "ctrl+a>t" = "launch --type=tab $SHELL";
      "ctrl+a>'" = "launch --location=hsplit $SHELL";
      "ctrl+a>\\" = "launch --location=vsplit $SHELL";

      # map kitty_mod+m>k move_window top
      # map kitty_mod+m>j move_window down
      # map kitty_mod+m>l move_window right
      # map kitty_mod+m>h move_window left

      "ctrl+a>h" = "neighboring_window left";
      "ctrl+a>l" = "neighboring_window right";
      "ctrl+a>k" = "neighboring_window top";
      "ctrl+a>j" = "neighboring_window down";

      "ctrl+a>," = "set_tab_title";
      "ctrl+a>z" = "toggle_layout stack";
      "ctrl+a>e" = "launch --type=overlay fish $EDITOR";
    };

    package = pkgs.kitty;
  };
}
