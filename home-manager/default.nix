{username, ...}: {
  imports = [
    ./modules
  ];

  home = {
    inherit username;

    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };

  xdg.enable = true;
  xdg.userDirs.enable = true;

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
  programs.go.enable = true;
  programs.zoxide.enable = true;
  services.udiskie.enable = true;
  programs.browserpass.enable = true;
  programs.opam.enable = true;

  home.sessionPath = ["$HOME/.local/bin"];

  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = ["graphical-session-pre.target"];
    };
  };
}
