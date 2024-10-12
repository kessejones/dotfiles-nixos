{
  pkgs,
  unstable-pkgs,
  username,
  ...
}: let
  home-dir = "/home/${username}";
in {
  programs.zellij = {
    enable = true;
    package = pkgs.zellij;
  };

  xdg.configFile."zellij/layouts/compact.kdl".text = ''
    layout {
        pane

        pane size=1 borderless=true {
            plugin location="file:${pkgs.zjstatus}/bin/zjstatus.wasm" {
                format_left  " {mode} #[fg=blue,bold]{session} {tabs}"
                format_right "{datetime}"
                format_space ""

                border_enabled  "false"
                border_char     "─"
                border_format   "#[fg=#white]{char}"
                border_position "top"

                hide_frame_for_single_pane "false"

                mode_normal  "#[fg=blue]●"
                mode_pane    "#[fg=yellow]▢"
                mode_scroll  "#[fg=yellow]▮"
                mode_search  "#[fg=yellow]∕"
                mode_session "#[fg=yellow]▤"
                mode_tab     "#[fg=yellow]◆"
                mode_tmux    "#[fg=yellow]▪"

                tab_normal   "#[fg=#6C7086] {name} "
                tab_active   "#[fg=#9399B2,bold] {name} "

                datetime          "{format} "
                datetime_format   "%A, %d %b %Y %H:%M"
                datetime_timezone "America/Sao_Paulo"
            }
        }
    }
  '';

  xdg.configFile."zellij/config.kdl".text = ''
    keybinds clear-defaults=true {
        normal {
        }

        locked {
            bind "Esc" { SwitchToMode "Normal"; }
        }

        resize {
            bind "Ctrl n" { SwitchToMode "Normal"; }
            bind "h" "Left" { Resize "Increase Left"; }
            bind "j" "Down" { Resize "Increase Down"; }
            bind "k" "Up" { Resize "Increase Up"; }
            bind "l" "Right" { Resize "Increase Right"; }
            bind "H" { Resize "Decrease Left"; }
            bind "J" { Resize "Decrease Down"; }
            bind "K" { Resize "Decrease Up"; }
            bind "L" { Resize "Decrease Right"; }
            bind "=" "+" { Resize "Increase"; }
            bind "-" { Resize "Decrease"; }
            bind "m" { SwitchToMode "Move"; }
        }
        pane {
            bind "Ctrl p" { SwitchToMode "Normal"; }
            bind "h" "Left" { MoveFocus "Left"; }
            bind "l" "Right" { MoveFocus "Right"; }
            bind "j" "Down" { MoveFocus "Down"; }
            bind "k" "Up" { MoveFocus "Up"; }
            bind "p" { SwitchFocus; }
            bind "n" { NewPane; SwitchToMode "Normal"; }
            bind "d" { NewPane "Down"; SwitchToMode "Normal"; }
            bind "r" { NewPane "Right"; SwitchToMode "Normal"; }
            bind "x" { CloseFocus; SwitchToMode "Normal"; }
            bind "f" { ToggleFocusFullscreen; SwitchToMode "Normal"; }
            bind "z" { TogglePaneFrames; SwitchToMode "Normal"; }
            bind "w" { ToggleFloatingPanes; SwitchToMode "Normal"; }
            bind "e" { TogglePaneEmbedOrFloating; SwitchToMode "Normal"; }
            bind "c" { SwitchToMode "RenamePane"; PaneNameInput 0;}
        }

        move {
            bind "Ctrl h" { SwitchToMode "Normal"; }
            bind "n" { MoveTab "Right"; }
            bind "p" { MoveTab "Left"; }
            bind "h" "Left" { MovePane "Left"; }
            bind "j" "Down" { MovePane "Down"; }
            bind "k" "Up" { MovePane "Up"; }
            bind "l" "Right" { MovePane "Right"; }
            bind "r" { SwitchToMode "Resize"; }
        }

        tab {
            bind "Ctrl t" { SwitchToMode "Normal"; }
            bind "r" { SwitchToMode "RenameTab"; TabNameInput 0; }
            bind "h" "Left" "Up" "k" { GoToPreviousTab; }
            bind "l" "Right" "Down" "j" { GoToNextTab; }
            bind "n" { NewTab; SwitchToMode "Normal"; }
            bind "x" { CloseTab; SwitchToMode "Normal"; }
            bind "s" { ToggleActiveSyncTab; SwitchToMode "Normal"; }
            bind "1" { GoToTab 1; SwitchToMode "Normal"; }
            bind "2" { GoToTab 2; SwitchToMode "Normal"; }
            bind "3" { GoToTab 3; SwitchToMode "Normal"; }
            bind "4" { GoToTab 4; SwitchToMode "Normal"; }
            bind "5" { GoToTab 5; SwitchToMode "Normal"; }
            bind "6" { GoToTab 6; SwitchToMode "Normal"; }
            bind "7" { GoToTab 7; SwitchToMode "Normal"; }
            bind "8" { GoToTab 8; SwitchToMode "Normal"; }
            bind "9" { GoToTab 9; SwitchToMode "Normal"; }
            bind "Tab" { ToggleTab; }
        }

        scroll {
            bind "Ctrl s" { SwitchToMode "Normal"; }
            bind "e" { EditScrollback; SwitchToMode "Normal"; }
            bind "s" { SwitchToMode "EnterSearch"; SearchInput 0; }
            bind "/" { SwitchToMode "EnterSearch"; SearchInput 0; }
            bind "Ctrl c" { ScrollToBottom; SwitchToMode "Normal"; }
            bind "j" "Down" { ScrollDown; }
            bind "k" "Up" { ScrollUp; }
            bind "Ctrl f" "PageDown" "Right" "l" { PageScrollDown; }
            bind "Ctrl b" "PageUp" "Left" "h" { PageScrollUp; }
            bind "d" { HalfPageScrollDown; }
            bind "u" { HalfPageScrollUp; }
        }

        search {
            bind "Ctrl s" { SwitchToMode "Normal"; }
            bind "Ctrl c" { ScrollToBottom; SwitchToMode "Normal"; }
            bind "j" "Down" { ScrollDown; }
            bind "k" "Up" { ScrollUp; }
            bind "Ctrl f" "PageDown" "Right" "l" { PageScrollDown; }
            bind "Ctrl b" "PageUp" "Left" "h" { PageScrollUp; }
            bind "d" { HalfPageScrollDown; }
            bind "u" { HalfPageScrollUp; }
            bind "n" { Search "down"; }
            bind "N" { Search "up"; }
            bind "p" { Search "up"; }
            bind "c" { SearchToggleOption "CaseSensitivity"; }
            bind "w" { SearchToggleOption "Wrap"; }
            bind "o" { SearchToggleOption "WholeWord"; }
        }

        entersearch {
            bind "Ctrl c" "Esc" { SwitchToMode "Scroll"; }
            bind "Enter" { SwitchToMode "Search"; }
        }

        renametab {
            bind "Ctrl c" { SwitchToMode "Normal"; }
            bind "Esc" { UndoRenameTab; SwitchToMode "Tab"; }
        }

        renamepane {
            bind "Ctrl c" { SwitchToMode "Normal"; }
            bind "Esc" { UndoRenamePane; SwitchToMode "Pane"; }
        }

        session {
            bind "Ctrl o" { SwitchToMode "Normal"; }
            bind "Ctrl s" { SwitchToMode "Scroll"; }
            bind "d" { Detach; }
        }

        tmux {
            bind "t" {
                NewTab {
                  cwd "${home-dir}";
                  layout "compact";
                };

                SwitchToMode "Normal";
            }

            bind "h" { MoveFocus "Left"; SwitchToMode "Normal"; }
            bind "l" { MoveFocus "Right"; SwitchToMode "Normal"; }
            bind "j" { MoveFocus "Down"; SwitchToMode "Normal"; }
            bind "k" { MoveFocus "Up"; SwitchToMode "Normal"; }

            bind "d" { Detach; }
            bind "x" { CloseFocus; SwitchToMode "Normal"; }
            bind "p" { GoToPreviousTab; SwitchToMode "Normal"; }
            bind "n" { GoToNextTab; SwitchToMode "Normal"; }

            bind "y" { ToggleTab; }
            bind "1" { GoToTab 1; SwitchToMode "Normal"; }
            bind "2" { GoToTab 2; SwitchToMode "Normal"; }
            bind "3" { GoToTab 3; SwitchToMode "Normal"; }
            bind "4" { GoToTab 4; SwitchToMode "Normal"; }
            bind "5" { GoToTab 5; SwitchToMode "Normal"; }
            bind "6" { GoToTab 6; SwitchToMode "Normal"; }
            bind "7" { GoToTab 7; SwitchToMode "Normal"; }
            bind "8" { GoToTab 8; SwitchToMode "Normal"; }
            bind "9" { GoToTab 9; SwitchToMode "Normal"; }

            bind "," { SwitchToMode "RenameTab"; TabNameInput 0; }

            bind "z" { ToggleFocusFullscreen; SwitchToMode "Normal"; }

            bind "\\" {
              NewPane {
                cwd "/home/kesse"
                direction "Down"
              };
              SwitchToMode "Normal";
            }
            bind "'" {
              NewPane {
                cwd "/home/kesse"
                direction "Right"
              };
              SwitchToMode "Normal";
            }

            bind "w" { ToggleFloatingPanes; SwitchToMode "Normal"; }
            bind ";" { ToggleFloatingPanes; SwitchToMode "Normal"; }
            bind "e" { TogglePaneEmbedOrFloating; SwitchToMode "Normal"; }

            bind "r" { SwitchToMode "Resize"; }
            bind "m" { SwitchToMode "Move"; }
            bind "S" { SwitchToMode "Scroll"; }

            bind "s" {
                LaunchOrFocusPlugin "zellij:session-manager" {
                    floating true
                    move_to_focused_tab true
                };
                SwitchToMode "Normal"
            }
        }

        shared_except "normal" "locked" {
            bind "Enter" "Esc" { SwitchToMode "Normal"; }
        }

        shared_except "tmux" "locked" {
            bind "Ctrl t" { SwitchToMode "Tmux"; }
        }
    }

    plugins {
        tab-bar { path "tab-bar"; }
        status-bar { path "status-bar"; }
        strider { path "strider"; }
        compact-bar { path "compact-bar"; }
        session-manager { path "session-manager"; }
    }

    session_serialization false
    simplified_ui true
    pane_frames false
    auto_layout false
    theme "catppuccin-mocha"
    default_cwd "${home-dir}"
    default_layout "compact"
    scrollback_editor "${unstable-pkgs.neovim-unwrapped}/bin/nvim"
    ui {
        pane_frames {
            rounded_corners true
        }
    }
    // scroll_buffer_size 10000
    // themes {
    //     dracula {
    //         fg 248 248 242
    //         bg 40 42 54
    //         red 255 85 85
    //         green 80 250 123
    //         yellow 241 250 140
    //         blue 98 114 164
    //         magenta 255 121 198
    //         orange 255 184 108
    //         cyan 139 233 253
    //         black 0 0 0
    //         white 255 255 255
    //     }
    // }
  '';
}
