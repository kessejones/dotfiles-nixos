{pkgs, ...}: {
  home.packages = with pkgs; [
    # command utils
    fzf
    exa
    ripgrep
    gum
    gh
    fd
    unzip
    xclip

    # dev
    php
    php.packages.composer
    rustup
    gcc
    gnumake
    nodejs

    # desktop
    gnome.nautilus
    gnome.file-roller
    (cinnamon.nemo-with-extensions.override {extensions = [cinnamon.nemo-fileroller];})
    qalculate-gtk
    deluge
    arandr
    brave

    # system manager
    pulseaudio
    pavucontrol

    # games
    TLauncher
  ];
}
