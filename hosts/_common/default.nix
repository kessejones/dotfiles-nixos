{pkgs, ...}: {
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
  programs.command-not-found.enable = false;
  programs.gamemode.enable = true;

  documentation.nixos.enable = false;

  environment.shellAliases = {
    ls = "${pkgs.eza}/bin/eza";
    ll = "${pkgs.eza}/bin/eza --long --group";
    la = "${pkgs.eza}/bin/eza --long --group --all";
    lt = "${pkgs.eza}/bin/eza --tree";
    ltt = "${pkgs.eza}/bin/eza --long --group --tree";
    lt2 = "${pkgs.eza}/bin/eza --tree -L 2";
    lt3 = "${pkgs.eza}/bin/eza --tree -L 3";
    lt4 = "${pkgs.eza}/bin/eza --tree -L 4";
    lt5 = "${pkgs.eza}/bin/exa --tree -L 5";
  };

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  hardware.keyboard.zsa.enable = true;
  hardware.bluetooth.enable = true;
}
