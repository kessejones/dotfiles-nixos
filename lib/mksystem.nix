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

  # Remove this later
  nur-modules = import inputs.nur {
    nurpkgs = nixpkgs.legacyPackages.${system};
    pkgs = nixpkgs.legacyPackages.${system};
  };

  unstable-pkgs = import inputs.unstable-nixpkgs {
    inherit system;
  };

  overlays = [
    (import ../pkgs {inherit inputs unstable-pkgs;})
    inputs.nur.overlays.default
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
        home-manager.sharedModules = [
          inputs.nixcord.homeManagerModules.nixcord
          inputs.catppuccin.homeManagerModules.catppuccin
          inputs.dotfiles.homeManagerModules.dotfiles
        ];
        home-manager.extraSpecialArgs = {
          inherit username unstable-pkgs;
        };
      }

      # Remove this later
      inputs.nur.modules.nixos.default
      nur-modules.repos.LuisChDev.modules.nordvpn

      inputs.catppuccin.nixosModules.catppuccin
    ];
  }
