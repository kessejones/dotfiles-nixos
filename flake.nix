{
  description = "My Home Manager Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nur.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nur,
    home-manager,
  }: {
    nixosConfigurations = let
      username = "kesse";
      system = "x86_64-linux";

      nur-modules = import nur {
        nurpkgs = nixpkgs.legacyPackages.${system};
        pkgs = nixpkgs.legacyPackages.${system};
      };

      common-modules = [
        {
          nixpkgs.overlays = [
            (import ./pkgs)
            nur.overlay
          ];
        }
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ./home-manager;
          home-manager.extraSpecialArgs = {
            inherit username;
          };
        }

        nur.nixosModules.nur
        nur-modules.repos.LuisChDev.modules.nordvpn
      ];
    in {
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit username;};

        modules =
          common-modules
          ++ [
            ./hosts/laptop
          ];

        inherit system;
      };

      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit username;};

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
