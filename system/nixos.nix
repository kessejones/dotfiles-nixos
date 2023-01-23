{
  config,
  pkgs,
  ...
}: {
  imports = [./hardware.nix];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fonts = {
    fontconfig = {
      enable = true;
    };
  };

  hardware = {
    opengl.enable = true;

    pulseaudio = {
      enable = true;
    };
  };

  networking = {
    firewall.enable = false;

    hostName = "ainz-ooal-gown";
    networkmanager.enable = true;
  };

  sound.enable = true;

  time.timeZone = "America/Sao_Paulo";

  users = {
    users.kesse = {
      extraGroups = ["audio" "docker" "wheel"];

      home = "/home/kesse";
      isNormalUser = true;
      shell = pkgs.fish;
    };
  };

  services.xserver.enable = true;
  services.xserver.libinput.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.windowManager.awesome.enable = true;
  services.xserver.displayManager.defaultSession = "AwesomeXsession";
  services.xserver.displayManager.session = [
    {
      manage = "desktop";
      name = "AwesomeXsession";
      start = "$HOME/.Xsession";
    }
  ];

  services.openssh.enable = true;

  system.stateVersion = "22.11"; # Did you read the comment?

  programs.nm-applet.enable = true;
}
