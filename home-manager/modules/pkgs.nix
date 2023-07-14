{pkgs, ...}: {
  home.packages = with pkgs; [
    # command utils
    fzf
    exa
    ripgrep
    gum
    gh
    fd
    zip
    unzip
    xclip

    # dev
    php
    php.packages.composer
    rustup
    gcc
    gnumake
    nodejs
    yarn

    # desktop
    (cinnamon.nemo-with-extensions.override {extensions = [cinnamon.nemo-fileroller];})
    cinnamon.pix
    qalculate-gtk
    arandr
    brave
    librewolf
    gimp

    # torrents
    deluge
    qbittorrent

    # system manager
    pulseaudio
    pavucontrol
    mpc_cli

    # games
    TLauncher
    prismlauncher
    minecraft

    oraclejdk17
  ];
}
