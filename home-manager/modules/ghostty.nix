{pkgs, ...}: {
  home.packages = [pkgs.ghostty];

  # xdg.configFile."ghostty/config".text = ''
  #
  # '';
}
