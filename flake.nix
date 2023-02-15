{
  description = "My Home Manager Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
  }: {
    nixosConfigurations = {
      main = let
        username = "kesse";
      in
        nixpkgs.lib.nixosSystem {
          specialArgs = {inherit username;};

          modules = [
            {nixpkgs.overlays = [(import ./overlays.nix)];}
            ./system/nixos.nix

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

          system = "x86_64-linux";
        };
    };
  };
}
