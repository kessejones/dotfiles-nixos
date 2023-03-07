{pkgs, ...}: {
  programs.discocss = {
    enable = true;
    discordAlias = true;

    css = builtins.readFile "${pkgs.catppuccin.discocss}/dist/catppuccin-mocha.theme.css";
  };
}
