{pkgs, ...}: {
  fish_default_mode_prompt.body = ''
    set -l reset_color $mode_color_normal
    set -l mode_text ""
    if test "$fish_key_bindings" = fish_vi_key_bindings
        or test "$fish_key_bindings" = fish_hybrid_key_bindings
          switch $fish_bind_mode
            case default
              set mode_text "[N]"
              set reset_color $mode_color_normal
            case insert
              set mode_text "[I]"
              set reset_color $mode_color_insert
            case replace_one
              set mode_text "[R]"
              set reset_color $mode_color_green
            case replace
              set mode_text "[R]"
              set reset_color $mode_color_replace
            case visual
              set mode_text "[V]"
              set reset_color $mode_color_visual
          end
      end

      if test -n "$SSH_TTY" || test -n "$SSH_CLIENT"
        set -l machine (hostname)
        _power_prompt --text="[$machine]" --background=$fish_color_lavender --foreground=$fish_color_base --reset=$reset_color --bold
        set reset_color "292c3c"
      end

      if test -n "$fish_private_mode"
        _power_prompt --text=' 󰗹 ' --background="292c3c" --foreground="cdd6f4" --reset=$reset_color --bold
      end

    if test "$fish_key_bindings" = fish_vi_key_bindings
        or test "$fish_key_bindings" = fish_hybrid_key_bindings
      _power_prompt --text=$mode_text --background=$reset_color --foreground=$mode_fg --reset=$mode_color_reset --bold
      echo -n -s ' '
    end
  '';

  fish_prompt.body = ''
    set -l cwd (basename (prompt_pwd))
    set -g __fish_git_prompt_showuntrackedfiles true
    set -g __fish_git_prompt_showdirtystate true
    set -g __fish_git_prompt_showupstream true
    set -g __fish_git_prompt_char_upstream_equal ""

    set -l git_info (fish_git_prompt)
    if test -n "$git_info"
      _power_prompt --text="$cwd " --background=$fish_color_cwd_bg --foreground=$fish_color_cwd_fg --reset=$fish_color_git_bg
      _power_prompt --text="$git_info" --background=$fish_color_git_bg --foreground=$fish_color_git_fg --reset=normal
    else
      _power_prompt --text="$cwd " --background=$fish_color_cwd_bg --foreground=$fish_color_cwd_fg --reset=normal
    end

    echo -n -s ' ' $normal
  '';

  fish_user_key_bindings.body = ''
    bind --erase -- \ct
    bind --erase --mode insert -- \ct

    bind --user -M insert \ch _fzf_change_directory_home
    bind --user -M insert \ce dotconf
    bind --user -M insert \cf accept-autosuggestion
    bind --user -M insert \cg accept-autosuggestion execute
    bind --user -M insert \cr _fzf_search_history

    bind --user -M insert \co '$EDITOR'
    bind --user -M insert \cp __fish_toggle_private_mode

    set -g fish_key_bindings fish_vi_key_bindings
  '';

  fish_greeting.body = "";

  __fish_toggle_private_mode.body = ''
    if test -n "$fish_private_mode"
      exec fish
    else
      exec fish --private
    end
    commandline --function repaint
  '';

  _power_prompt.body = ''
    argparse 'b/background=' 'f/foreground=' 'r/reset=' 'o/bold' 't/text=' -- $argv
        or return

    set_color normal
    set_color -b $_flag_b
    if test -n "$_flag_o"
        set_color --bold $_flag_f
    else
        set_color $_flag_f
    end
    echo -n -s $_flag_t
    set_color -b $_flag_r

    if test -n "$_flag_o"
      set_color --bold $_flag_b
    else
      set_color $_flag_b
    end

    echo -n -s ''
  '';

  dotconf.body = let
    list = [
      "dotfiles $HOME/.dotfiles"
      "nvim $HOME/.config/nvim"
      "awesome $HOME/.config/awesome"
      "fish $HOME/.config/fish"
      "yabai $HOME/.config/yabai"
      "skhd $HOME/.config/skhd"
      "alacritty $HOME/.config/alacritty"
      "kitty $HOME/.config/kitty"
      "tmux $HOME/.config/tmux"
    ];
  in ''

    function __folder_list
      ${(builtins.concatStringsSep "\n" (map (i: ''echo ${i}'') list))}
    end

    set -l dots (__folder_list)

    clear
    set -l selected (gum choose --limit 1 $dots | cut -d' ' -f2)
    if test -n "$selected"
      cd $selected
    end

    commandline --function repaint
  '';

  _fzf_change_directory_home.body = ''
    set fd_opts --type d --color=always --strip-cwd-prefix $fzf_fd_opts
    set fzf_arguments --multi --ansi $fzf_dir_opts
    set --append fd_opts --base-directory=$HOME
    set --append fzf_arguments --header-first --header "Find directory ($HOME)"

    set --append fd_opts --exclude Applications/
    set --append fd_opts --exclude Library/
    set --append fd_opts --exclude Movies/
    set --append fd_opts --exclude Music/
    set --append fd_opts --exclude node_modules/

    set file_paths_selected (fd $fd_opts 2>/dev/null | _fzf_wrapper $fzf_arguments)

    if test $status -eq 0
      cd $HOME/$file_paths_selected
    end

    commandline --function repaint
  '';

  _fzf_search_history.body = ''
    # history merge incorporates history changes from other fish sessions
    builtin history merge

    set command_with_ts (
      # Reference https://devhints.io/strftime to understand strftime format symbols
      builtin history --null --show-time="%d/%m - %H:%M:%S │ " |
      _fzf_wrapper --read0 \
        --tiebreak=index \
        --query=(commandline) \
        --header-first \
        --header 'Search in history' \
        # preview current command using fish_ident in a window at the bottom 3 lines tall
        # --preview="echo -- {4..} | fish_indent --ansi" \
        # --preview-window="bottom:3:wrap" \
        --bind "ctrl-space:execute(echo 'REPLACE │ {}')+abort,enter:execute(echo 'RUN │ {}')+abort" \
        $fzf_history_opts |
      string collect
    )

    if test $status -eq 0
      set selected_parts (string split --max 3 " │ " $command_with_ts)

      set command_selected $selected_parts[3]
      switch $selected_parts[1]
        case RUN
          eval $command_selected
        case REPLACE
          commandline --replace -- $command_selected
      end
    end

    commandline --function repaint
  '';

  _fzf_wrapper.body = ''
    set --local --export SHELL (command --search fish)

    if not set --query FZF_DEFAULT_OPTS
      set --export FZF_DEFAULT_OPTS '--cycle --layout=reverse --border --height=90% --preview-window=wrap --marker="*"'
    end

    ${pkgs.fzf}/bin/fzf $argv
  '';
}
