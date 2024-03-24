{pkgs, ...}: {
  system.stateVersion = "23.11";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.pulseaudio = true;
  nixpkgs.config.nvidia.acceptLicense = true;

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
}
