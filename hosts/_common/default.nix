{
  pkgs,
  config,
  ...
}: {
  imports = [
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
  programs.command-not-found.enable = false;

  documentation.nixos.enable = false;

  environment.shellAliases = {
    ls = "${pkgs.exa}/bin/exa";
    ll = "${pkgs.exa}/bin/exa --long --group";
    la = "${pkgs.exa}/bin/exa --long --group --all";
    lt = "${pkgs.exa}/bin/exa --tree";
    ltt = "${pkgs.exa}/bin/exa --long --group --tree";
    lt2 = "${pkgs.exa}/bin/exa --tree -L 2";
    lt3 = "${pkgs.exa}/bin/exa --tree -L 3";
    lt4 = "${pkgs.exa}/bin/exa --tree -L 4";
    lt5 = "${pkgs.exa}/bin/exa --tree -L 5";
  };
}