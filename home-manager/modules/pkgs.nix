{pkgs, ...}: {
  home.packages = with pkgs; [
    # command utils
    fzf
    eza
    ripgrep
    gum
    fd
    zip
    unzip
    unrar
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
    gnome.file-roller
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
    #TLauncher
    (prismlauncher.override {jdks = [zulu8 zulu17];})
    minecraft

    #oraclejdk17

    discord
    immersed-vr
    sidequest

    ngrok
  ];
}
