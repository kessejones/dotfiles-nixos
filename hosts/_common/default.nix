{...}: {
  imports = [
    ./modules
  ];

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

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  hardware.keyboard.zsa.enable = true;
  hardware.bluetooth.enable = true;
}
