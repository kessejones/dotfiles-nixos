{...}: {
  programs.wezterm = {
    enable = true;
    extraConfig = '''';
  };

  xdg.configFile."wezterm/wezterm.lua".text = ''
    local wezterm = require("wezterm")

    local config = {}

    if wezterm.config_builder then
        config = wezterm.config_builder()
    end

    wezterm.on("format-tab-title", function(tab, _tabs, _panes, _config, _hover, max_width)
        local pane = tab.active_pane
        local process_name = string.gsub(pane.foreground_process_name, "(.*[/\\])(.*)", "%2")
        local title_text = string.format(" %d:%s ", tab.tab_index + 1, process_name)

        if tab.is_active then
            return {
                { Background = { Color = "#89b4fa" } },
                { Text = title_text },
            }
        end
        return title_text
    end)

    wezterm.on("update-right-status", function(window, pane)
        local name = window:active_key_table()
        window:set_right_status(name or "")
    end)

    config.term = "wezterm"
    config.front_end = "OpenGL"
    config.check_for_updates = false
    config.color_scheme = "Catppuccin Mocha"
    config.colors = {
        background = "#1E1E2F",
    }

    config.font_size = 10
    config.font = wezterm.font_with_fallback({
      { family = "JetBrainsMono Nerd Font", weight = "Medium" },
      { family = "Meslo LG S", scale = 1.3 },
    })

    config.window_padding = {
        left = 5,
        right = 0,
        top = 5,
        bottom = 0,
    }

    config.window_close_confirmation = "NeverPrompt"
    config.freetype_load_target = "HorizontalLcd"
    config.bold_brightens_ansi_colors = true
    config.default_cwd = wezterm.home_dir
    config.hide_tab_bar_if_only_one_tab = true
    config.tab_bar_at_bottom = true
    config.use_fancy_tab_bar = false
    config.default_cursor_style = "BlinkingBlock"
    config.cursor_blink_rate = 400
    config.animation_fps = 1
    config.cursor_blink_ease_in = "Constant"
    config.cursor_blink_ease_out = "Constant"
    config.enable_scroll_bar = false
    config.window_decorations = "RESIZE"

    config = require("keys")(config)

    return config
  '';

  xdg.configFile."wezterm/keys.lua".text = ''
    local wezterm = require("wezterm")
    local act = wezterm.action

    local leader = { key = "a", mods = "CTRL" }
    local keys = {
        { key = 'K', mods = 'CTRL|SHIFT', action = act.SendString '\x1b[75;5u' },
        { key = 'J', mods = 'CTRL|SHIFT', action = act.SendString '\x1b[74;5u' },
        { key = 'H', mods = 'CTRL|SHIFT', action = act.SendString '\x1b[72;5u' },
        { key = 'L', mods = 'CTRL|SHIFT', action = act.SendString '\x1b[76;5u' },
        {
            key = "t",
            mods = "LEADER",
            action = act.SpawnCommandInNewTab({ cwd = wezterm.home_dir }),
        },
        {
            key = "\\",
            mods = "LEADER",
            action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
        },
        {
            key = "'",
            mods = "LEADER",
            action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
        },
        {
            key = "m",
            mods = "LEADER",
            action = act.TogglePaneZoomState,
        },
        { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
        { key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },

        {
            key = "h",
            mods = "LEADER",
            action = act.ActivatePaneDirection("Left"),
        },
        {
            key = "l",
            mods = "LEADER",
            action = act.ActivatePaneDirection("Right"),
        },
        {
            key = "j",
            mods = "LEADER",
            action = act.ActivatePaneDirection("Down"),
        },
        {
            key = "k",
            mods = "LEADER",
            action = act.ActivatePaneDirection("Up"),
        },

        {
            key = "1",
            mods = "LEADER",
            action = act.ActivateTab(0),
        },
        {
            key = "2",
            mods = "LEADER",
            action = act.ActivateTab(1),
        },
        {
            key = "3",
            mods = "LEADER",
            action = act.ActivateTab(2),
        },
        {
            key = "4",
            mods = "LEADER",
            action = act.ActivateTab(3),
        },
        {
            key = "5",
            mods = "LEADER",
            action = act.ActivateTab(4),
        },
        {
            key = "6",
            mods = "LEADER",
            action = act.ActivateTab(5),
        },
        {
            key = "7",
            mods = "LEADER",
            action = act.ActivateTab(6),
        },
        {
            key = "8",
            mods = "LEADER",
            action = act.ActivateTab(7),
        },
        {
            key = "9",
            mods = "LEADER",
            action = act.ActivateTab(8),
        },
        {
            key = "0",
            mods = "LEADER",
            action = act.ActivateTab(9),
        },
        {
            key = "q",
            mods = "LEADER",
            action = act.CloseCurrentPane({ confirm = false }),
        },
        {
            key = "p",
            mods = "LEADER|SHIFT",
            action = act.MoveTabRelative(-1),
        },
        {
            key = "n",
            mods = "LEADER|SHIFT",
            action = act.MoveTabRelative(1),
        },
        {
            key = "l",
            mods = "LEADER|CTRL",
            action = act.AdjustPaneSize({ "Right", 5 }),
        },
        {
            key = "h",
            mods = "LEADER|CTRL",
            action = act.AdjustPaneSize({ "Left", 5 }),
        },
        {
            key = "k",
            mods = "LEADER|CTRL",
            action = act.AdjustPaneSize({ "Up", 5 }),
        },
        {
            key = "j",
            mods = "LEADER|CTRL",
            action = act.AdjustPaneSize({ "Down", 5 }),
        },
        {
            key = "c",
            mods = "CTRL|SHIFT",
            action = act.CopyTo("Clipboard"),
        },
        {
            key = "v",
            mods = "CTRL|SHIFT",
            action = act.PasteFrom("Clipboard"),
        },
        {
            key = "r",
            mods = "LEADER",
            action = act.ActivateKeyTable({ name = "resize_panes", one_shot = false }),
        },
        {
            key = ";",
            mods = "LEADER",
            action = act.ActivateCommandPalette,
        },
        {
            key = "v",
            mods = "LEADER",
            action = act.ActivateCopyMode,
        },
        {
            key = ",",
            mods = "LEADER",
            action = act.PromptInputLine({
                description = "Enter new name for tab",
                action = wezterm.action_callback(function(window, _pane, line)
                    if line then
                        window:active_tab():set_title(line)
                    end
                end),
            }),
        },
        {
            key = "s",
            mods = "LEADER",
            action = act.ActivateKeyTable({ name = "workspaces", one_shot = true }),
        },
        {
          key = 'u',
          mods = 'LEADER',
          action = wezterm.action.QuickSelectArgs {
            label = 'Open URL',
            patterns = {
              'https?://\\S+',
            },
            action = wezterm.action_callback(function(window, pane)
              local url = window:get_selection_text_for_pane(pane)
              window:copy_to_clipboard(url, 'Clipboard')
            end),
          },
        },
    }

    local key_tables = {
        resize_panes = {
            {
                key = "l",
                action = act.AdjustPaneSize({ "Right", 1 }),
            },
            {
                key = "h",
                action = act.AdjustPaneSize({ "Left", 1 }),
            },
            {
                key = "k",
                action = act.AdjustPaneSize({ "Up", 1 }),
            },
            {
                key = "j",
                action = act.AdjustPaneSize({ "Down", 1 }),
            },
            {
                key = "Escape",
                action = act.PopKeyTable,
            },
            {
                key = "Enter",
                action = act.PopKeyTable,
            },
        },
        workspaces = {
            {
                key = "c",
                action = act.SwitchToWorkspace,
            },
            {
                key = "l",
                action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
            },
            {
                key = "n",
                action = act.SwitchWorkspaceRelative(1),
            },
            {
                key = "p",
                action = act.SwitchWorkspaceRelative(-1),
            },
        },
    }

    return function(config)
        config.disable_default_key_bindings = true
        config.leader = leader
        config.keys = keys
        config.key_tables = key_tables

        return config
    end
  '';
}
