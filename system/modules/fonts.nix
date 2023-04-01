{pkgs, ...}: {
  fonts = {
    fontconfig = {
      enable = true;
    };

    fonts = with pkgs; [
      material-icons

      (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly" "Hack" "JetBrainsMono"];})
    ];
  };
}
