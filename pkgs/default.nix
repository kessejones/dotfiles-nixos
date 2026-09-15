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
    version = "12.16.4";
  in
    prev.floorp-bin-unwrapped.overrideAttrs (old: {
      src = prev.fetchurl {
        url = "https://github.com/Floorp-Projects/Floorp/releases/download/v${version}/floorp-linux-x86_64.tar.xz";
        hash = "sha256-UZL88awADg9eVtCMsIjeeZZxlYVz0v5dQrg1LxWZvfc=";
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
    version = "next-3.9";
    src = final.fetchFromGitHub {
      owner = "tmux";
      repo = "tmux";
      rev = "483912351048bf60937bb8df950bcea12606a3a2";
      sha256 = "sha256-gxRBXxDoXY1xlqiLxYweR0eAJH0zdZ29IvJ477pOlVk=";
    };

    patches = [];
  });
}
