{
  config,
  pkgs,
  lib,
  username,
  ...
}: {
  imports = [./hardware.nix];

  boot.kernelPackages = pkgs.linuxPackages_5_10;
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

      (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly" "Hack" "JetBrainsMono"];})
    ];
  };

  hardware = {
    opengl.enable = true;

    nvidia.prime = {
      sync.enable = true;

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
    nvidia.modesetting.enable = true;
  };

  networking = {
    firewall.enable = false;

    hostName = "ainz-ooal-gown";
    networkmanager.enable = true;
  };

  specialisation = {
    external-display.configuration = {
      system.nixos.tags = ["external-display"];
      hardware.nvidia.prime.offload.enable = lib.mkForce false;
      hardware.nvidia.powerManagement.enable = lib.mkForce false;
    };
  };

  sound.enable = true;
  security.rtkit.enable = true;

  time.timeZone = "America/Sao_Paulo";

  users = {
    users.${username} = {
      uid = 1000;
      home = "/home/${username}";
      initialPassword = "essek";
      isNormalUser = true;
      shell = pkgs.fish;
      extraGroups = ["audio" "docker" "wheel" "networkmanager"];
    };
  };

  services = {
    xserver = {
      enable = true;
      layout = "br";

      dpi = 96;
      libinput.enable = true;

      videoDrivers = ["nvidia"];

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

    openssh.enable = true;

    dbus.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      config.pipewire-pulse = {
        "context.exec" = [
          {
            path = "pactl";
            args = "load-module module-switch-on-connect";
          }
        ];
      };
    };

    autorandr = {
      enable = true;
      defaultTarget = "laptop-dual";
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
  nixpkgs.config.pulseaudio = true;

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
      warn-dirty = false
    '';

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };

    package = pkgs.nixUnstable;

    settings = {
      auto-optimise-store = true;
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    curl
    cryptsetup
    podman-compose
    alsa-utils
  ];

  environment.shells = [
    pkgs.fish
  ];

  virtualisation = {
    podman = {
      enable = true;
      defaultNetwork.settings.dns_name.enabled = true;
    };
    docker.enable = true;
  };
}
