{pkgs, ...}: {
  fonts = {
    fontconfig = {
      enable = true;
    };

    packages = with pkgs; [
      material-icons
      meslo-lg
      cascadia-code
      monaspace

      (nerdfonts.override {
        fonts = [
          "NerdFontsSymbolsOnly"
          "Hack"
          "JetBrainsMono"
          "Ubuntu"
          "FiraCode"
          "CascadiaCode"
          "Monaspace"
        ];
      })
    ];
  };
}
