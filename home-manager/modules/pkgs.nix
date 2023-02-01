{pkgs}: {
  home.packages = with pkgs; [
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
}
