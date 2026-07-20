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

    gcc
    gnumake

    # Desktop apps
    (nemo-with-extensions.override {extensions = [nemo-preview];})
    pix
    qalculate-gtk
    gnome-calendar
    file-roller
    arandr

    gimp
    aseprite

    # Browsers
    helium-browser
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
        zulu25
      ];
    })

    sidequest
  ];

  unstable = with pkgs.unstable; [
    zig
    lazygit
    lazydocker
    jujutsu
    jjui
  ];
in {
  home.packages = stable ++ unstable;

  programs.floorp = {
    enable = true;
  };
}
