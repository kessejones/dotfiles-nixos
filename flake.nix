{
  description = "Dotfiles NIXOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    unstable-nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    zjstatus.url = "github:dj95/zjstatus";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nur,
    home-manager,
    zjstatus,
    unstable-nixpkgs,
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
            (import ./pkgs)
            nur.overlay
            (final: prev: {
              zjstatus = zjstatus.packages.${prev.system}.default;
            })
          ];
        }
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ./home-manager;
          home-manager.extraSpecialArgs = {
            inherit username unstable-pkgs;
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
