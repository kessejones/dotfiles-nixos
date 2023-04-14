{
  config,
  pkgs,
  lib,
  username,
  ...
}: rec {
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

  services.udiskie.enable = true;
  services.mpd = {
    enable = true;

    network.startWhenNeeded = true;
    musicDirectory = "${config.home.homeDirectory}/Music";

    extraConfig = ''
      audio_output {
        type "pipewire"
        name "PipeWire Sound Server"
      }
    '';
  };
}
