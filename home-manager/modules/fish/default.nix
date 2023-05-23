{pkgs, ...}: {
  # xdg.configFile.fish = {
  #   recursive = true;
  #   source = ./config;
  # };

  programs.fish = {
    enable = true;

    functions = import ./functions.nix {pkgs = pkgs;};
    shellAliases = import ./alias.nix;

    interactiveShellInit = ''
      ## disable welcome message
      set fish_greeting
      set fish_cursor_insert line
      set fish_cursor_replace underscore
      set fish_cursor_replace_one underscore

      set fish_prompt_separator 1

      ## local config
      if test -f ~/.config.fish
          source ~/.config.fish
      end

      ## custom theme
      ${import ./colors.nix}
      ${import ./theme.nix}

      ## FZF variables
      set --global _fzf_search_vars_command '_fzf_search_variables (set --show | psub) (set --names | psub)'
      set -Ux FZF_CTRL_T_COMMAND ""
      set -Ux FZF_DEFAULT_OPTS "\
      --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
      --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
      --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
      --layout=reverse \
      --border \
      --height=100%"

      ## Gum variables
      export GUM_CHOOSE_SELECTED_PREFIX="[x] "
      export GUM_CHOOSE_UNSELECTED_PREFIX="[ ] "
      export GUM_CHOOSE_CURSOR_PREFIX="[ ] "
      export GUM_FILTER_SELECTED_PREFIX="[x] "
      export GUM_FILTER_UNSELECTED_PREFIX="[ ] "
      export GUM_FILTER_CURSOR_PREFIX="[ ] "
      export GUM_FILTER_INDICATOR="> "
      export GUM_INPUT_PROMPT="> "

      ## zoxide variables
      zoxide init fish | source
    '';
  };
}
