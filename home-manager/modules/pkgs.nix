{pkgs, ...}: {
  programs.home-manager.enable = true;
  programs.zoxide.enable = true;
  programs.direnv.enable = true;

  home.packages = with pkgs; [
    # CLI tools
    ripgrep
    glow
    fd
    zip
    unzip
    unrar
    xclip
    lazydocker
    jq
    k9s
    nvtopPackages.nvidia
    lazygit
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
    zig

    # Desktop apps
    (nemo-with-extensions.override {extensions = [nemo-fileroller];})
    pix
    gnome-calculator
    gnome-calendar
    file-roller
    arandr
    gimp
    freetube

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
    lutris

    sidequest
  ];
}
