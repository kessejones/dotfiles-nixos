{
  pkgs,
  unstable-pkgs,
  ...
}: let
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

    # Desktop apps
    (nemo-with-extensions.override {extensions = [nemo-fileroller];})
    pix
    gnome-calculator
    gnome-calendar
    file-roller
    arandr
    gimp

    # Browsers
    floorp
    brave

    # Torrents clients
    deluge-gtk

    # System manager/configuration
    pulseaudio
    pavucontrol
    mpc_cli

    # Games
    (prismlauncher.override {jdks = [zulu8 zulu17 zulu21];})

    anki
  ];
  unstable = with unstable-pkgs; [
    zig
    lazygit
    lazydocker
    wofi
  ];
in {
  home.packages = stable ++ unstable;
}
