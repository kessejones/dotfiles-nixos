{pkgs, ...}: let
  stable = with pkgs; [
    # CLI tools
    ripgrep
    glow
    fd
    zip
    unzip
    unrar
    xclip
    jq
    k9s
    nvtopPackages.nvidia
    carapace
    warpd
    atuin
    scrot

    # dev
    php
    # php.packages.composer
    gcc
    gnumake
    nodejs
    yarn
    rustup
    lua5_1

    # Desktop apps
    (nemo-with-extensions.override {extensions = [nemo-fileroller];})
    pix
    gnome-calculator
    gnome-calendar
    file-roller
    arandr

    gimp
    aseprite

    # Browsers
    glide-browser
    brave

    # Torrents clients
    deluge-gtk

    # System manager/configuration
    pulseaudio
    pavucontrol
    mpc

    # Games
    lutris
    pcsx2
    (prismlauncher.override {
      jdks = [
        zulu8
        zulu17
        zulu21
      ];
    })

    anki
    sidequest
  ];

  unstable = with pkgs.unstable; [
    zig
    lazygit
    lazydocker
    wofi
    opencode
    jujutsu
    jjui
    quickshell
  ];
in {
  home.packages = stable ++ unstable;

  programs.floorp = {
    enable = true;
  };
}
