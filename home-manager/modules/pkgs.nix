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
    lazygit

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
    (nemo-with-extensions.override {extensions = [nemo-fileroller];})
    pix
    gnome-calculator
    gnome-calendar
    file-roller
    arandr
    brave
    librewolf
    gimp

    # torrents
    # qbittorrent
    deluge-gtk

    # system manager
    pulseaudio
    pavucontrol
    mpc_cli

    # games
    (prismlauncher.override {jdks = [zulu8 zulu17 zulu21];})

    discord
    sidequest

    atuin
  ];
}
