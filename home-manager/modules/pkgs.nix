{pkgs, ...}: {
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
    fd

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

    arandr

    mpv
    pavucontrol
    pulseaudio
    deluge

    xclip

    TLauncher
  ];
}
