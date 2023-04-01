{pkgs, ...}: {
  virtualisation = {
    podman = {
      enable = false;
      defaultNetwork.settings.dns_name.enabled = true;
    };
    docker.enable = true;
  };
}
