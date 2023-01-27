{
  config,
  pkgs,
  lib,
  ...
}: let
  username = "kesse";

  kvimSource = builtins.fetchTarball "https://github.com/kessejones/kvim.git";

  dotfiles =
    builtins.fetchTarball "https://github.com/kessejones/dotfiles/archive/main.tar.gz";
in {
  home = {
    inherit username;

    homeDirectory = "/home/${username}";
    stateVersion = "22.11";
  };

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

  programs.nix-index.enable = true;

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

  xdg.enable = true;
  xdg.configFile.nvim.recursive = true;
  xdg.configFile.nvim.source = kvimSource;

  xdg.configFile.awesome.recursive = true;
  xdg.configFile.awesome.source = "${dotfiles}/.config/awesome";

  xdg.configFile.fish.recursive = true;
  xdg.configFile.fish.source = "${dotfiles}/.config/fish";

  xdg.configFile."gtk-2.0".recursive = true;
  xdg.configFile."gtk-2.0".source = "${dotfiles}/.config/gtk-2.0";

  xdg.configFile."gtk-3.0".recursive = true;
  xdg.configFile."gtk-3.0".source = "${dotfiles}/.config/gtk-3.0";

  xdg.configFile.btop.recursive = true;
  xdg.configFile.btop.source = "${dotfiles}/.config/btop";

  xdg.configFile.gh.recursive = true;
  xdg.configFile.gh.source = "${dotfiles}/.config/gh";

  xdg.configFile.rofi.recursive = true;
  xdg.configFile.rofi.source = "${dotfiles}/.config/rofi";

  xdg.configFile.mpv.recursive = true;
  xdg.configFile.mpv.source = "${dotfiles}/.config/mpv";

  xdg.dataFile.fonts.recursive = true;
  xdg.dataFile.fonts.source = "${dotfiles}/.fonts";

  xdg.configFile.alacritty.recursive = true;
  xdg.configFile.alacritty.source = "${dotfiles}/.config/alacritty";

  home.file.".gitconfig".source = "${dotfiles}/.gitconfig";

  home.file.".icons".recursive = true;
  home.file.".icons".source = "${dotfiles}/.icons";

  home.file.".themes".recursive = true;
  home.file.".themes".source = "${dotfiles}/.themes";

  gtk.enable = true;
}
