{
  config,
  pkgs,
  lib,
  username,
  ...
}: {
  imports = [
    ./hardware.nix
    ./modules
  ];

  boot.kernelPackages = pkgs.linuxPackages_6_2;
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
      gfxmodeEfi = "1920x1080";
      theme = pkgs.catppuccin.grub-mocha;
    };
  };

  fonts = {
    fontconfig = {
      enable = true;
    };

    fonts = with pkgs; [
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
        lightdm = {
          enable = true;
          greeters.gtk = {
            enable = true;

            theme = {
              name = "Catppuccin-Mocha-Standard-Blue-Dark";
              package = pkgs.catppuccin-gtk.override {
                variant = "mocha";
              };
            };
            iconTheme = {
              name = "Papirus";
              package = pkgs.papirus-icon-theme;
            };
          };
          background = "#181825";

          extraSeatDefaults = ''
            display-setup-script=${pkgs.writeShellScript "lightdm-setup-autorandr" ''
              ${pkgs.autorandr}/bin/autorandr -c
            ''}
          '';
        };
      };
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
  programs.fish.enable = true;

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
