{pkgs, ...}: {
  programs.neovim = {
    enable = true;
  };

  xdg.configFile.nvim = {
    recursive = true;
    source = pkgs.kesse.kvim;
  };
}
