{
  inputs,
  unstable-pkgs,
}: final: prev: {
  kitty = unstable-pkgs.kitty;

  zjstatus = inputs.zjstatus.packages.${prev.system}.default;
  ghostty = inputs.ghostty.packages.${prev.system}.default;

  nodeCustomPackages = {
    prettierd = final.callPackage ./prettierd {};
  };

  floorp-bin-unwrapped = let
    version = "12.7.0";
  in
    prev.floorp-bin-unwrapped.overrideAttrs (old: {
      src = prev.fetchurl {
        url = "https://github.com/Floorp-Projects/Floorp/releases/download/v${version}/floorp-linux-x86_64.tar.xz";
        hash = "sha256-feIRCZuyB8xwUoI1FMWJQ6yupgC2aAavADQ9mrk0zMM=";
      };
    });

  awesome-git = (prev.awesome.override
    {
      lua = prev.luajit;
      gtk3Support = true;
    })
    .overrideAttrs (old: {
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

  picom-git = let
    removeFromList = toRemove: list: final.lib.foldl (l: e: final.lib.remove e l) list toRemove;
  in
    prev.picom.overrideAttrs (old: {
      pname = "picom-git";
      version = "v12.5";
      src = final.fetchFromGitHub {
        owner = "yshui";
        repo = "picom";
        rev = "v12.5";
        fetchSubmodules = false;
        sha256 = "sha256-H8IbzzrzF1c63MXbw5mqoll3H+vgcSVpijrlSDNkc+o=";
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
