{
  config,
  pkgs,
  lib,
  ...
}: let
  username = "kesse";

  dotfiles = builtins.fetchGit {
    url = "https://github.com/kessejones/dotfiles.git";
  };
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

  programs.discocss = {
    enable = true;
    discordAlias = true;

    css = builtins.readFile "${pkgs.customDiscocss.catppuccin}/dist/catppuccin-mocha.theme.css";
  };

  programs.bat = {
    enable = true;
    config = {theme = "catppuccin";};
    themes = {
      catppuccin =
        builtins.readFile
        (pkgs.customBat.catppuccin + "/Catppuccin-macchiato.tmTheme");
    };
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

    configFile = {
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

  home.file = {
    ".scripts" = {
      recursive = true;
      source = "${dotfiles}/.scripts";
    };

    ".gitconfig".source = "${dotfiles}/.gitconfig";
  };

  gtk = {
    enable = true;

    theme = {
      name = "Catppuccin-Mocha-Standard-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        variant = "mocha";
      };
    };

    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "Catppuccin-Mocha-Dark";
      package = pkgs.catppuccin-cursors;
    };
  };
}
