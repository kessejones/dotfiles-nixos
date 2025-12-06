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
    floorp-bin-unwrapped
    brave

    # Torrents clients
    deluge-gtk

    # System manager/configuration
    pulseaudio
    pavucontrol
    mpc

    # Games
    (prismlauncher.override {jdks = [zulu8 zulu17 zulu21];})

    anki
    sidequest
  ];

  unstable = with unstable-pkgs; [
    zig
    lazygit
    lazydocker
    wofi
    opencode
  ];
in {
  home.packages = stable ++ unstable;

  # programs.floorp = {
  #   enable = true;
  #   # package = pkgs.floorp-bin-unwrapped;
  # };
}
