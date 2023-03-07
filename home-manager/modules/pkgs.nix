{pkgs, ...}: {
  home.packages = with pkgs; [
    btop
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
    # cinnamon.nemo
    # cinnamon.nemo-fileroller

    arandr

    mpv
    pavucontrol
    pulseaudio
    deluge

    xclip

    TLauncher
  ];
}
