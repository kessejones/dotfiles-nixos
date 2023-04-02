{
  config,
  pkgs,
  lib,
  username,
  ...
}: {
  imports = [
    ./hardware.nix
    ./modules
  ];

  sound.enable = true;
  security.rtkit.enable = true;
  time.timeZone = "America/Sao_Paulo";

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.nm-applet.enable = true;
  programs.dconf.enable = true;
  programs.fish.enable = true;

  environment.shellAliases = {
    ls = "${pkgs.exa}/bin/exa";
    ll = "${pkgs.exa}/bin/exa --long --group";
    la = "${pkgs.exa}/bin/exa --long --group --all";
    lt = "${pkgs.exa}/bin/exa --long --group --tree";
  };
}
