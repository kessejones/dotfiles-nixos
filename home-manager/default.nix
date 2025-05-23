{username, ...}: {
  imports = [./modules];

  home = {
    inherit username;

    homeDirectory = "/home/${username}";
    stateVersion = "24.11";
    sessionPath = ["$HOME/.local/bin"];
  };

  programs.home-manager.enable = true;
  catppuccin.flavor = "mocha";
}
