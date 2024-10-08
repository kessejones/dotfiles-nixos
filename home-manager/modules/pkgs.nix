{pkgs, ...}: {
  home.packages = with pkgs; [
    # command utils
    fzf
    eza
    ripgrep
    gum
    glow
    fd
    zip
    unzip
    unrar
    xclip
    lazydocker
    hurl
    jq
    kaf
    k9s
    nvtopPackages.nvidia

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
    zig

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
    qbittorrent

    # system manager
    pulseaudio
    pavucontrol
    mpc_cli

    # games
    (prismlauncher.override {jdks = [zulu8 zulu17 zulu21];})

    discord
    sidequest

    ngrok
  ];
}
