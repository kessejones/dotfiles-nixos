{username, ...}: {
  imports = [
    ./modules
  ];

  home = {
    inherit username;

    homeDirectory = "/home/${username}";
    stateVersion = "22.11";
  };

  xdg.enable = true;
  xdg.userDirs.enable = true;

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
  programs.go.enable = true;
  programs.zoxide.enable = true;
  services.udiskie.enable = true;

  home.sessionPath = ["$HOME/.local/bin"];

  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 300;
        height = 300;
        offset = "30x50";
        origin = "top-right";
        transparency = 10;
        frame_color = "#eceff1";
        font = "Droid Sans 9";
      };

      urgency_normal = {
        background = "#37474f";
        foreground = "#eceff1";
        timeout = 10;
      };
    };
  };
}
