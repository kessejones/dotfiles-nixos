{inputs}: final: prev: rec {
  unstable = import inputs.unstable-nixpkgs {
    inherit (final) config;
    inherit (final.stdenv.hostPlatform) system;
  };

  kitty = unstable.kitty;

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
    (old: rec {
      patches = [];
      cmakeFlags = old.cmakeFlags ++ ["-DGENERATE_MANPAGES=OFF"];
      version = "c104846a2cc954ce97077146e5964667c81c2165";
      src = final.fetchFromGitHub {
        owner = "awesomeWM";
        repo = "awesome";
        rev = version;
        fetchSubmodules = false;
        sha256 = "sha256-l3fGfMEy2i4sNOvsxYFB5gsgswJPRLHk35cxQNB1tR0=";
      };

      postPatch = ''
        patchShebangs tests/examples/_postprocess.lua
        patchShebangs tests/examples/_postprocess_cleanup.lua
      '';
    });

  tmux-git = final.tmux.overrideAttrs (old: {
    version = "3.7-rc";
    src = final.fetchFromGitHub {
      owner = "tmux";
      repo = "tmux";
      rev = "bbd4768bb62354796bbb5fb7ab978c436f808559";
      sha256 = "sha256-yMi7WwoW2rfis/nsVRIz9ew45CLS8hKfQTUIVbZgTF8=";
    };

    patches = [];
  });
}
