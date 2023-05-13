{
  description = "My Home Manager Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nur.url = "github:nix-community/NUR";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nur,
    neovim-nightly,
    home-manager,
  }: {
    nixosConfigurations = let
      username = "kesse";
      system = "x86_64-linux";

      common-modules = [
        {nixpkgs.overlays = [(import ./pkgs) nur.overlay neovim-nightly.overlay];}
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ./home-manager/nixos.nix;
          home-manager.extraSpecialArgs = {
            inherit username;
          };
        }
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
