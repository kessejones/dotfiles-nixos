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

  services = {
    xserver = {
      enable = true;
      layout = "br";

      libinput.enable = true;

      videoDriver = ["mesa"];

      windowManager = {
        awesome = {
          enable = true;
        };
      };

      displayManager = {
        # lightdm.enable = true;
        gdm.enable = true;
        defaultSession = "AwesomeXsession";
        session = [
          {
            manage = "desktop";
            name = "AwesomeXsession";
            start = "$HOME/.Xsession";
          }
        ];
      };
    };

    picom.enable = true;

    openssh.enable = true;
  };

  system.stateVersion = "22.11"; # Did you read the comment?

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.nm-applet.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    curl
  ];
}
