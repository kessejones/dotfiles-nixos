{
  pkgs,
  lib,
  ...
}: {
  programs.neovim = {
    enable = true;
  };

  home.activation = let
    path = "$HOME/.config/nvim";
  in {
    installKVim = lib.hm.dag.entryAfter ["writeBoundary"] ''
      if [ ! -d "${path}" ]; then
        ${pkgs.git}/bin/git clone https://github.com/kessejones/kvim.git ${path}
      fi
    '';
  };
}
