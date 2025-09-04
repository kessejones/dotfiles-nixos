{
  nixpkgs,
  inputs,
}: name: {
  username,
  system,
}: let
  host-config = ../hosts/${name};
  home-manager-config = ../home-manager;
  home-manager-nixos = inputs.home-manager.nixosModules;

  unstable-pkgs = import inputs.unstable-nixpkgs {
    inherit system;
  };

  overlays = [
    (import ../pkgs {inherit inputs unstable-pkgs;})
    inputs.dotfiles.overlays.default
  ];
in
  nixpkgs.lib.nixosSystem {
    inherit system;

    specialArgs = {
      inherit system username unstable-pkgs;
    };

    modules = [
      {
        nixpkgs.config.allowUnfree = true;
        nixpkgs.overlays = overlays;
      }

      host-config

      home-manager-nixos.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${username} = home-manager-config;
        home-manager.backupFileExtension = "hm-backup";
        home-manager.sharedModules = [
          inputs.catppuccin.homeModules.catppuccin
          inputs.dotfiles.homeManagerModules.dotfiles
        ];
        home-manager.extraSpecialArgs = {
          inherit username unstable-pkgs;
        };
      }

      inputs.dotfiles.modules.dotfiles
      inputs.catppuccin.nixosModules.catppuccin
    ];
  }
