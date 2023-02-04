{
  pkgs,
  lib,
  ...
}: {
  programs.neovim = {
    enable = true;
  };

  home.activation = {
    installKVim = lib.hm.dag.entryAfter ["writeBoundary"] ''
      if [ ! -d "$HOME/.config/nvim" ]; then
        ${pkgs.git}/bin/git clone https://github.com/kessejones/kvim.git $HOME/.config/nvim
      fi
    '';
  };
}
