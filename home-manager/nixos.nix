{
  config,
  pkgs,
  lib,
  ...
}: let
  username = "kesse";
in {
  home = {
    inherit username;

    homeDirectory = "/home/${username}";
    stateVersion = "22.11";
  };

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;

  programs.firefox = {
    enable = true;
    profiles.default.search = {
      default = "DuckDuckGo";
    };
  };

  programs.discocss = let
    src = {
      url = "https://github.com/catppuccin/discord.git";
      ref = "refs/heads/gh-pages";
    };

    catppuccin-files = builtins.fetchGit src;
    theme-file = "${catppuccin-files}/dist/catppuccin-mocha.theme.css";
  in {
    enable = true;
    discordAlias = true;

    css = builtins.readFile theme-file;
  };

  programs.kitty = {
    enable = true;

    theme = "Catppuccin-Mocha";
    font = {
      name = "Hack Nerd Font";
      size = 13;
    };

    settings = {
      cursor_blink_interval = 0;
      cursor_stop_blinking_after = 0;
      window_padding_width = 5;
    };

    package = pkgs.kitty;
  };

  programs.go.enable = true;
  programs.dconf.enable = true;

  home.packages = with pkgs; [
    neovim
    btop
    tmux
    fzf
    tree-sitter
    exa
    ripgrep
    gum
    git
    gh

    unzip
    php
    php.packages.composer

    cargo
    gcc
    gnumake

    nodejs

    alejandra

    alacritty
    rofi

    gnome.nautilus
  ];

  xdg = {
    enable = true;

    configFile = let
      dotfiles = builtins.fetchGit {
        url = "https://github.com/kessejones/dotfiles.git";
      };
    in {
      nvim = {
        recursive = true;
        source = builtins.fetchGit {
          url = "https://github.com/kessejones/kvim.git";
        };
      };

      awesome = {
        recursive = true;
        source = "${dotfiles}/.config/awesome";
      };

      fish = {
        recursive = true;
        source = "${dotfiles}/.config/fish";
      };

      alacritty = {
        recursive = true;
        source = "${dotfiles}/.config/alacritty";
      };
    };
  };

  gtk = {
    enable = true;

    theme = {
      name = "Catppuccin-Mocha-Standard-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        variant = "mocha";
      };
    };
  };
}
