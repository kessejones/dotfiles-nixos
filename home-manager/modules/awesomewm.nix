{
  pkgs,
  lib,
  ...
}: {
  home.activation.install-awesomewm = let
    repo = "https://github.com/kessejones/awesome-config.git.git";
    path = "$HOME/.config/awesome";
  in
    lib.mkAfter ''
      if [ ! -d "${path}" ]; then
        ${pkgs.git}/bin/git clone ${repo} ${path}
      fi
    '';
}
