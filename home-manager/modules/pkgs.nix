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
    pass
    yazi

    # dev
    php
    php.packages.composer
    gcc
    gnumake
    nodejs
    yarn
    rustup
    maven
    gradle

    # desktop
    (cinnamon.nemo-with-extensions.override {extensions = [cinnamon.nemo-fileroller];})
    cinnamon.pix
    gnome.gnome-calculator
    gnome.gnome-calendar
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
