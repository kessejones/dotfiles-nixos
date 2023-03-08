{
  pkgs,
  lib,
  ...
}: {
  home.activation = let
    path = "$HOME/.config/awesome";
  in {
    installAwesome = lib.hm.dag.entryAfter ["writeBoundary"] ''
      if [ ! -d "${path}" ]; then
        ${pkgs.git}/bin/git clone https://github.com/kessejones/awesome-config.git ${path}
      fi
    '';
  };
}
