{unstable-pkgs, ...}: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = unstable-pkgs.hyprland;
  };

  programs.waybar = {
    enable = true;
    package = unstable-pkgs.waybar;
  };

  environment.systemPackages = with unstable-pkgs; [
    copyq
    wl-clipboard
  ];
}
