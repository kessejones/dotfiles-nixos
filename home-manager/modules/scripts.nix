{pkgs, ...}: let
  nixProfileRemove = pkgs.writeShellScript "nix-profile-remove" ''
    nix profile list | awk -F ' ' '{ print $1 " " $2 }' | gum choose --no-limit | cut -d' ' -f1 | xargs -r nix profile remove
  '';
in {
  home.packages = [nixProfileRemove];
}
