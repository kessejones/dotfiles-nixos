{pkgs, ...}: {
  fonts = {
    fontconfig = {
      enable = true;
    };

    packages = with pkgs.unstable; [
      material-icons
      meslo-lg

      maple-mono.NF

      nerd-fonts.jetbrains-mono
      nerd-fonts.hack
      nerd-fonts.ubuntu
      nerd-fonts.monaspace
      nerd-fonts.caskaydia-cove
    ];
  };
}
