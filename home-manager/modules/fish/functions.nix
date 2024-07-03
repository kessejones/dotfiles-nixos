{pkgs, ...}: {
  fish_default_mode_prompt.body = '''';

  fish_prompt.body = ''
    set -l cwd (basename (prompt_pwd))
    set -l git_info (string trim (fish_git_prompt) --chars " ()")

    echo -n (__power_text_rounded --text="$cwd" --background=$fish_color_blue --foreground=$fish_color_base --reset=normal --bold)
    if test -n "$git_info"
        echo -n ' '
        echo -n (__power_text_rounded --text="$git_info" --background=$fish_color_mauve --foreground=$fish_color_base --reset=normal --bold)
    end

    set -l mode_color (set_color normal)
    switch $fish_bind_mode
        case default
            set mode_color (set_color $fish_color_red)
        case insert
            set mode_color (set_color $fish_color_subtext1)
        case visual
            set mode_color (set_color $fish_color_mauve)
    end

    echo -n "$mode_color |>"
    set_color normal
    echo -n -s ' '
  '';

  fish_user_key_bindings.body = ''
    bind --erase -- \ct
    bind --erase --mode insert -- \ct

    bind --user -M insert \ch _fzf_change_directory_home
    bind --user -M insert \ce dotconf
    bind --user -M insert \cf accept-autosuggestion
    bind --user -M insert \cg accept-autosuggestion execute
    bind --user -M insert \cr _fzf_search_history
    bind --user -M insert \cgl _fzf_search_git_log
    bind --user -M insert \cgs _fzf_search_git_status

    bind --user -m insert -M default \cf accept-autosuggestion repaint-mode
    bind --user -m insert -M default \cg accept-autosuggestion execute repaint-mode

    #bind --user -M default gl end-of-line
    #bind --user -M default gh beginning-of-line

    #bind --user -M visual -m insert escape repaint-mode
    #bind --user -m default -M replace escape repaint-mode

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

  __power_text_rounded.body = ''
    argparse 'b/background=' 'f/foreground=' 'r/reset=' 'o/bold' 't/text=' -- $argv
        or return

    set -l text "$_flag_t"
    if set -ql _flag_o
        set text (string join "" -- (set_color --bold $_flag_f) $text)
    else
        set text (string join "" -- (set_color $_flag_f) $text)
    end

    string join "" -- (set_color -b $_flag_r) (set_color $_flag_b) "" (set_color -b $_flag_b) "$text" $(set_color -b $_flag_r) (set_color $_flag_b) ""
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
        --preview="echo -- {5..} | fish_indent --ansi" \
        --preview-window="bottom:3:wrap" \
        --bind="ctrl-space:execute(echo 'REPLACE │ {}')+abort" \
        --bind="enter:execute(echo 'RUN │ {}')+abort" \
        --bind="ctrl-y:execute(echo 'COPY │ {}')+abort" \
        $fzf_history_opts |
      string collect
    )

    if test $status -eq 0
      set selected_parts (string split --max 3 " │ " $command_with_ts)

      set command_selected $selected_parts[3]
      switch $selected_parts[1]
        case RUN
          commandline --replace -- $command_selected
        case COPY
          echo "$command_selected" | xclip -selection clipboard
          # eval $command_selected
        # case REPLACE
        #   commandline --replace -- $command_selected
      end
    end

    commandline --function repaint
  '';

  _fzf_search_git_log.body = ''
    if not git rev-parse --git-dir >/dev/null 2>&1
        echo '_fzf_search_git_log: Not in a git repository.' >&2
    else
        set log_fmt_str '%C(bold blue)%h%C(reset) - %C(cyan)%ad%C(reset) %C(yellow)%d%C(reset) %C(normal)%s%C(reset)  %C(dim normal)[%an]%C(reset)'
        set selected_log_lines (
            git log --color=always --format=format:$log_fmt_str --date=short | \
            _fzf_wrapper --ansi \
                --header "Search in Git Log" \
                --header-first \
                --multi \
                --tiebreak=index \
                --preview='git show --color=always {1}' \
                --query=(commandline --current-token) \
                --bind="ctrl-s:toggle" \
                --bind="ctrl-a:toggle-all" \
                --bind="ctrl-y:execute-silent(echo -n {2..} | xclip)+abort" \
                --bind="ctrl-d:preview-half-page-down" \
                --bind="ctrl-u:preview-half-page-up" \
                $fzf_git_log_opts
        )
        if test $status -eq 0
            for line in $selected_log_lines
                set abbreviated_commit_hash (string split --field 1 " " $line)
                set full_commit_hash (git rev-parse $abbreviated_commit_hash)
                set --append commit_hashes $full_commit_hash
            end
            commandline --current-token --replace (string join ' ' $commit_hashes)
        end
    end

    commandline --function repaint
  '';

  _fzf_search_git_status.body = ''
    if not git rev-parse --git-dir >/dev/null 2>&1
        echo '_fzf_search_git_status: Not in a git repository.' >&2
    else
        set -f preview_cmd '_fzf_preview_changed_file {}'
        if set --query fzf_diff_highlighter
            set preview_cmd "$preview_cmd | $fzf_diff_highlighter"
        end

        set -f selected_paths (
            git -c color.status=always status --short |
            _fzf_wrapper --ansi \
                --multi \
                --prompt="Git Status> " \
                --query=(commandline --current-token) \
                --preview=$preview_cmd \
                --nth="2.." \
                --bind="ctrl-s:toggle" \
                --bind="ctrl-a:toggle-all" \
                --bind="ctrl-y:execute-silent(echo -n {2..} | xclip)+abort" \
                --bind="ctrl-d:preview-half-page-down" \
                --bind="ctrl-u:preview-half-page-up" \
                $fzf_git_status_opts
        )
        if test $status -eq 0
            # git status --short automatically escapes the paths of most files for us so not going to bother trying to handle
            # the few edges cases of weird file names that should be extremely rare (e.g. "this;needs;escaping")
            set -f cleaned_paths

            for path in $selected_paths
                if test (string sub --length 1 $path) = R
                    set --append cleaned_paths (string split -- "-> " $path)[-1]
                else
                    set --append cleaned_paths (string sub --start=4 $path)
                end
            end

            commandline --current-token --replace -- (string join ' ' $cleaned_paths)
        end
    end

    commandline --function repaint
  '';

  _fzf_preview_changed_file = {
    argumentNames = ["path_status"];

    body = ''
      # remove quotes because they'll be interpreted literally by git diff
      # no need to requote when referencing $path because fish does not perform word splitting
      # https://fishshell.com/docs/current/fish_for_bash_users.html
      set -f path (string unescape (string sub --start 4 $path_status))
      # first letter of short format shows index, second letter shows working tree
      # https://git-scm.com/docs/git-status/2.35.0#_short_format
      set -f index_status (string sub --length 1 $path_status)
      set -f working_tree_status (string sub --start 2 --length 1 $path_status)

      set -f diff_opts --color=always

      if test $index_status = '?'
          _fzf_report_diff_type Untracked
          _fzf_preview_file $path
      else if contains {$index_status}$working_tree_status DD AU UD UA DU AA UU
          # Unmerged statuses taken directly from git status help's short format table
          # Unmerged statuses are mutually exclusive with other statuses, so if we see
          # these, then safe to assume the path is unmerged
          _fzf_report_diff_type Unmerged
          git diff $diff_opts -- $path
      else
          if test $index_status != ' '
              _fzf_report_diff_type Staged

              # renames are only detected in the index, never working tree, so only need to test for it here
              # https://stackoverflow.com/questions/73954214
              if test $index_status = R
                  # diff the post-rename path with the original path, otherwise the diff will show the entire file as being added
                  set -f orig_and_new_path (string split --max 1 -- ' -> ' $path)
                  git diff --staged $diff_opts -- $orig_and_new_path[1] $orig_and_new_path[2]
                  # path currently has the form of "original -> current", so we need to correct it before it's used below
                  set path $orig_and_new_path[2]
              else
                  git diff --staged $diff_opts -- $path
              end
          end

          if test $working_tree_status != ' '
              _fzf_report_diff_type Unstaged
              git diff $diff_opts -- $path
          end
      end
    '';
  };

  _fzf_report_diff_type = {
    argumentNames = ["diff_type"];
    body = ''
      # number of "-" to draw is the length of the string to box + 2 for padding
      set -f repeat_count (math 2 + (string length $diff_type))
      set -f line (string repeat --count $repeat_count ─)
      set -f top_border ╭$line╮
      set -f btm_border ╰$line╯

      set_color yellow
      echo $top_border
      echo "│ $diff_type │"
      echo $btm_border
      set_color normal
    '';
  };

  _fzf_report_file_type = {
    argumentNames = ["file_type"];
    body = ''
      set_color red
      echo "Cannot preview '$file_path': it is a $file_type."
      set_color normal
    '';
  };

  _fzf_preview_file.body = ''
    # because there's no way to guarantee that _fzf_search_directory passes the path to _fzf_preview_file
    # as one argument, we collect all the arguments into one single variable and treat that as the path
    set -f file_path $argv

    if test -L "$file_path" # symlink
        # notify user and recurse on the target of the symlink, which can be any of these file types
        set -l target_path (realpath "$file_path")

        set_color yellow
        echo "'$file_path' is a symlink to '$target_path'."
        set_color normal

        _fzf_preview_file "$target_path"
    else if test -f "$file_path" # regular file
        if set --query fzf_preview_file_cmd
            # need to escape quotes to make sure eval receives file_path as a single arg
            eval "$fzf_preview_file_cmd '$file_path'"
        else
            bat --style=numbers --color=always "$file_path"
        end
    else if test -d "$file_path" # directory
        if set --query fzf_preview_dir_cmd
            # see above
            eval "$fzf_preview_dir_cmd '$file_path'"
        else
            # -A list hidden files as well, except for . and ..
            # -F helps classify files by appending symbols after the file name
            command ls -A -F "$file_path"
        end
    else if test -c "$file_path"
        _fzf_report_file_type "$file_path" "character device file"
    else if test -b "$file_path"
        _fzf_report_file_type "$file_path" "block device file"
    else if test -S "$file_path"
        _fzf_report_file_type "$file_path" socket
    else if test -p "$file_path"
        _fzf_report_file_type "$file_path" "named pipe"
    else
        echo "$file_path doesn't exist." >&2
    end
  '';

  _fzf_wrapper.body = ''
    set --local --export SHELL (command --search fish)

    if not set --query FZF_DEFAULT_OPTS
      set --export FZF_DEFAULT_OPTS '--cycle --layout=reverse --border --height=90% --preview-window=wrap --marker="*"'
    end

    ${pkgs.fzf}/bin/fzf $argv
  '';
}
