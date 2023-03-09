{pkgs, ...}: {
  home.packages = with pkgs; [
    btop
    fzf
    tree-sitter
    exa
    ripgrep
    gum
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
    clang-tools
    lua-language-server

    rofi

    gnome.nautilus
    # cinnamon.nemo
    # cinnamon.nemo-fileroller

    arandr

    pavucontrol
    pulseaudio
    deluge

    xclip

    TLauncher
  ];
}
