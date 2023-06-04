{config, ...}: {
  services.nordvpn.enable = true;

  nixpkgs.config.packageOverrides = pkgs: {
    nordvpn = config.nur.repos.LuisChDev.nordvpn;
  };
}
