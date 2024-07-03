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

  picom-git = prev.picom.overrideAttrs (old: {
    pname = "picom-git";
    version = "next";
    src = final.fetchFromGitHub {
      owner = "yshui";
      repo = "picom";
      rev = "65452048cfe89dbc616a94a13db5c0c8f791a831";
      fetchSubmodules = false;
      sha256 = "sha256-BLSG59bWQkGwss4yslpXcm3Ib1R1zUP279sT7vDTOLw=";
    };
    buildInputs =
      (old.buildInputs or [])
      ++ [
        final.pcre2
        final.xorg.xcbutil
      ];
  });
}
