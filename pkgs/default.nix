{inputs}: final: prev: rec {
  unstable = import inputs.unstable-nixpkgs {
    inherit (final) config;
    inherit (final.stdenv.hostPlatform) system;
  };

  kitty = unstable.kitty;

  glide-browser-bin = final.callPackage ./glide-browser {};
  glide-browser = final.callPackage ./glide-browser/desktop-item.nix {};

  zjstatus = inputs.zjstatus.packages.${prev.system}.default;
  ghostty = inputs.ghostty.packages.${prev.system}.default;

  nodeCustomPackages = {
    prettierd = final.callPackage ./prettierd {};
  };

  floorp-bin-unwrapped = let
    version = "12.14.0";
  in
    prev.floorp-bin-unwrapped.overrideAttrs (old: {
      src = prev.fetchurl {
        url = "https://github.com/Floorp-Projects/Floorp/releases/download/v${version}/floorp-linux-x86_64.tar.xz";
        hash = "sha256-D8O38ZLJrh3vOhYMaKLe5CyKAnfBtI3u3gvR8txp4xc=";
      };
    });

  awesome-git =
    (prev.awesome.override {
      lua = prev.luajit;
      gtk3Support = true;
    }).overrideAttrs
    (old: {
      patches = [];
      cmakeFlags = old.cmakeFlags ++ ["-DGENERATE_MANPAGES=OFF"];
      version = "41473c05ed9e85de66ffb805d872f2737c0458b6";
      src = final.fetchFromGitHub {
        owner = "awesomeWM";
        repo = "awesome";
        rev = "41473c05ed9e85de66ffb805d872f2737c0458b6";
        fetchSubmodules = false;
        sha256 = "sha256-dGceJ5cAxDSUPCqXYAZgzEeC9hd7GQMYPex7nCZ8SEg=";
      };

      postPatch = ''
        patchShebangs tests/examples/_postprocess.lua
        patchShebangs tests/examples/_postprocess_cleanup.lua
      '';
    });
}
