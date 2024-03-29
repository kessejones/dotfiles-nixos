{pkgs, ...}: let
  gum = "${pkgs.gum}/bin/gum";
  hm = "${pkgs.home-manager}/bin/home-manager";
  hm-remove = pkgs.writeShellScriptBin "hm-remove" ''
    ${hm} generations | ${gum} choose --height 20 --no-limit | awk '{ match($0, /id ([0-9]+) ->/, id); print id[1] }' | xargs ${hm} remove-generations
  '';
in {
  home.packages = [
    hm-remove
  ];
}
