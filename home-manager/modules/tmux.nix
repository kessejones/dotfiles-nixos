{...}: let
  base = "#1e1e2e";
  mantle = "#181825";
  surface0 = "#313244";
  overlay0 = "#6c7086";
  overlay1 = "#7f849c";
  text = "#cdd6f4";
  blue = "#89b4fa";

  status_bg = base;
  status_fg = text;
  session_bg = blue;
  session_fg = mantle;
  win_bg = surface0;
  win_fg = overlay1;
  win_active_bg = overlay0;
  win_active_fg = mantle;
in {
  programs.tmux = {
    enable = true;

    baseIndex = 1;
    escapeTime = 0;
    keyMode = "vi";
    prefix = "C-t";
    shortcut = "t";
    mouse = true;
    disableConfirmationPrompt = true;
    terminal = "tmux-256color";

    plugins = [];

    extraConfig = ''
      set -sa terminal-overrides ',xterm-kitty:RGB'
      set -sa terminal-features ",alacritty*:RGB,foot*:RGB,xterm-kitty*:RGB,xterm-256color:RGB"

      # global settings
      set -g focus-events on

      ## Window and pane index
      set -g renumber-windows on

      # Reload config
      bind r source-file ~/.config/tmux/tmux.conf \; \
      display-message "Config Reloaded."

      # Split windows
      bind | split-window -h
      bind - split-window -v

      bind \\ split-window -h
      bind \' split-window -v

      # next/prev layout
      bind u select-layout -p
      bind i select-layout -n

      # Moving window
      bind -r C-p swap-window -t -1 \; previous-window
      bind -r C-n swap-window -t +1 \; next-window

      unbind '"'
      unbind %

      # Enter copy-mode
      unbind space
      bind space copy-mode

      # Session
      unbind c
      bind c new-session
      bind D detach

      # paste content in current pane
      bind C paste-buffer

      # Pane switching (vim-like)
      bind h select-pane -L
      bind l select-pane -R
      bind k select-pane -U
      bind j select-pane -D

      # Resizing pane (vim-like)
      bind -r C-j resize-pane -D 2
      bind -r C-k resize-pane -U 2
      bind -r C-h resize-pane -L 2
      bind -r C-l resize-pane -R 2

      # Toggle zoom
      unbind m
      bind m resize-pane -Z

      # Vim-like visual mode
      bind -T copy-mode-vi v send-keys -X begin-selection

      # clipboard
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -i -f -selection primary | xclip -i -selection clipboard"

      # New window
      unbind t
      bind t new-window

      # panels
      set -g pane-border-style "fg=${blue}"
      set -g pane-active-border-style "bg=default,fg=${blue}"

      # status bar
      set -g status on
      set -g status-interval 2
      set -g status-bg "${status_bg}"
      set -g status-fg "${status_fg}"
      set -g status-left-length 20
      set -g window-status-style "fg=${win_fg},bg=${win_bg}"
      set -g window-status-current-style "fg=${win_active_fg},bg=${win_active_bg}"
      set -g window-status-separator ""
      set -g window-status-format "#[fg=${status_bg},nobold]#[fg=${win_fg},bold] #{?window_start_flag,, }#I:#W#{?window_flags,#F, } #[fg=${win_bg},bg=${status_bg},nobold]"
      set -g window-status-current-format "#[fg=${status_bg},nobold] #[fg=${win_active_fg},bold]#{?window_start_flag,, }#I:#W#{?window_flags,#F, } #[fg=${win_active_bg},bg=${status_bg},nobold]"
      set -g status-left "#[fg=${session_fg},bg=${session_bg},bold] #S #[bg=${status_bg},fg=${session_bg},nobold]"
      set -g status-right "#[fg=${session_bg},bg=${status_bg},bold]#[fg=${session_fg},bg=${session_bg},bold] %H:%M  %d/%m/%y "
    '';
  };
}
