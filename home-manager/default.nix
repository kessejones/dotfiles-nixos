{username, ...}: {
  imports = [./modules];

  home = {
    inherit username;

    homeDirectory = "/home/${username}";
    stateVersion = "24.11";
    sessionPath = ["$HOME/.local/bin"];
  };

  catppuccin.flavor = "mocha";

  xdg.enable = true;
  xdg.userDirs.enable = true;
}
