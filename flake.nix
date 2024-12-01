{
  description = "Dotfiles NIXOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    unstable-nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    zjstatus.url = "github:dj95/zjstatus";
    catppuccin.url = "github:catppuccin/nix";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dotfiles.url = "github:kessejones/dotfiles/feat/nixpkgs?dir=.config/nixpkgs";
  };

  outputs = inputs @ {
    nixpkgs,
    nur,
    home-manager,
    unstable-nixpkgs,
    catppuccin,
    dotfiles,
    ...
  }: {
    nixosConfigurations = let
      username = "kesse";
      system = "x86_64-linux";

      nur-modules = import nur {
        nurpkgs = nixpkgs.legacyPackages.${system};
        pkgs = nixpkgs.legacyPackages.${system};
      };

      unstable-pkgs = import unstable-nixpkgs {
        inherit system;
      };

      common-modules = [
        {
          nixpkgs.overlays = [
            (import ./pkgs {inherit inputs unstable-pkgs;})
            nur.overlay
            dotfiles.overlays.default
          ];
        }
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ./home-manager;
          home-manager.extraSpecialArgs = {
            inherit username unstable-pkgs catppuccin dotfiles;
          };
        }

        nur.nixosModules.nur
        nur-modules.repos.LuisChDev.modules.nordvpn
        catppuccin.nixosModules.catppuccin
      ];
    in {
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit username unstable-pkgs;};

        modules =
          common-modules
          ++ [
            ./hosts/laptop
          ];

        inherit system;
      };

      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit username unstable-pkgs;};

        modules =
          common-modules
          ++ [
            ./hosts/desktop
          ];

        inherit system;
      };
    };
  };
}
