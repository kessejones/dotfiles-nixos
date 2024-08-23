final: prev: {
  nordvpn = final.callPackage ./nordvpn {};

  nodeCustomPackages = {
    prettierd = final.callPackage ./prettierd {};
  };

  discord = prev.discord.override {withOpenASAR = true;};
  awesome-git =
    (prev.awesome.override
      {
        lua = prev.luajit;
        gtk3Support = true;
      })
    .overrideAttrs (old: {
      patches = [];
      cmakeFlags = old.cmakeFlags ++ ["-DGENERATE_MANPAGES=OFF"];
      version = "8b1f8958b46b3e75618bc822d512bb4d449a89aa";
      src = final.fetchFromGitHub {
        owner = "awesomeWM";
        repo = "awesome";
        rev = "8b1f8958b46b3e75618bc822d512bb4d449a89aa";
        fetchSubmodules = false;
        sha256 = "sha256-ZGZ53IWfQfNU8q/hKexFpb/2mJyqtK5M9t9HrXoEJCg=";
      };

      postPatch = ''
        patchShebangs tests/examples/_postprocess.lua
        patchShebangs tests/examples/_postprocess_cleanup.lua
      '';
    });

  picom-git = let
    removeFromList = toRemove: list: final.lib.foldl (l: e: final.lib.remove e l) list toRemove;
  in
    prev.picom.overrideAttrs (old: {
      pname = "picom-git";
      version = "v12-rc2";
      src = final.fetchFromGitHub {
        owner = "yshui";
        repo = "picom";
        rev = "v12-rc2";
        fetchSubmodules = false;
        sha256 = "sha256-59I6uozu4g9hll5U/r0nf4q92+zwRlbOD/z4R8TpSdo";
      };
      nativeBuildInputs =
        (removeFromList [final.asciidoc] old.nativeBuildInputs)
        ++ [
          final.asciidoctor
        ];
      buildInputs =
        [
          final.pcre2
          final.xorg.xcbutil
          final.libepoxy
        ]
        ++ (removeFromList [
            final.xorg.libXinerama
            final.xorg.libXext
            final.pcre
          ]
          old.buildInputs);
    });
}
