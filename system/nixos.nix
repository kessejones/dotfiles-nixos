{
  config,
  pkgs,
  ...
}: {
  imports = [./hardware.nix];

  boot.loader = {
    efi = {
      efiSysMountPoint = "/boot";
    };

    grub = {
      enable = true;
      version = 2;
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
    };
  };

  fonts = {
    fontconfig = {
      enable = true;
    };

    fonts = with pkgs; [
      hack-font
      material-icons

      (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly" "Hack"];})
    ];
  };

  hardware = {
    opengl.enable = true;
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
      extraGroups = ["audio" "docker" "wheel" "networkmanager"];

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

      windowManager = {
        awesome = {
          enable = true;
        };
      };

      displayManager = {
        lightdm.enable = true;
        # defaultSession = "AwesomeXsession";
        # session = [
        #   {
        #     manage = "desktop";
        #     name = "AwesomeXsession";
        #     start = "$HOME/.Xsession";
        #   }
        # ];
      };
    };

    picom = {
      enable = true;
      fade = true;
      shadow = true;
      fadeDelta = 4;
    };

    openssh.enable = true;

    dbus.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  system.stateVersion = "22.11"; # Did you read the comment?

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.nm-applet.enable = true;
  programs.dconf.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    curl
  ];
}
