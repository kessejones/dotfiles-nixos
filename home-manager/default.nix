{
  username,
  catppuccin,
  ...
}: {
  imports = [
    ./modules
    catppuccin.homeManagerModules.catppuccin
  ];

  home = {
    inherit username;

    homeDirectory = "/home/${username}";
    stateVersion = "24.05";
  };

  catppuccin.flavor = "mocha";

  xdg.enable = true;
  xdg.userDirs.enable = true;

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
  programs.go.enable = true;
  programs.zoxide.enable = true;
  services.udiskie.enable = true;
  services.easyeffects.enable = true;
  programs.opam.enable = true;
  programs.direnv.enable = true;

  home.sessionPath = ["$HOME/.local/bin"];

  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = ["graphical-session-pre.target"];
    };
  };
}
