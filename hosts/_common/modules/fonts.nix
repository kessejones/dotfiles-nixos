{pkgs, ...}: {
  fonts = {
    fontconfig = {
      enable = true;
    };

    packages = with pkgs; [
      material-icons
      meslo-lg
      cascadia-code

      (nerdfonts.override {
        fonts = [
          "NerdFontsSymbolsOnly"
          "Hack"
          "JetBrainsMono"
          "Ubuntu"
          "FiraCode"
        ];
      })
    ];
  };
}
