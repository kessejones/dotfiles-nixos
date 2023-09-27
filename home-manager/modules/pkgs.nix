{pkgs, ...}: {
  home.packages = with pkgs; [
    # command utils
    fzf
    eza
    ripgrep
    gum
    gh
    fd
    zip
    unzip
    xclip
    lazydocker

    # dev
    php
    php.packages.composer
    gcc
    gnumake
    nodejs
    yarn
    rustup

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

    discord
  ];
}
