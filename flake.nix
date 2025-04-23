{
  description = "Dotfiles NIXOS";

  inputs = {
    # NIXOS repositories
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    unstable-nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Zellij statusbar
    zjstatus.url = "github:dj95/zjstatus";

    # Catppuccin theme
    catppuccin.url = "github:catppuccin/nix";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Discord Client
    nixcord = {
      url = "github:KaylorBen/nixcord";
    };

    # Ghostty Terminal
    ghostty.url = "github:ghostty-org/ghostty";

    # Shared dotfiles (testing)
    dotfiles.url = "github:kessejones/dotfiles?dir=.config/nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    username = "kesse";
    mkSystem = import ./lib/mksystem.nix {
      inherit nixpkgs inputs;
    };
  in {
    nixosConfigurations.desktop = mkSystem "desktop" {
      inherit username;
      system = "x86_64-linux";
    };

    nixosConfigurations.laptop = mkSystem "laptop" {
      inherit username;
      system = "x86_64-linux";
    };
  };
}
