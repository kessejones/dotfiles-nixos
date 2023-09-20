final: prev: {
  TLauncher = final.callPackage ./tlauncher {};
  oraclejdk17 = final.callPackage ./oraclejdk17 {};
  nordvpn = final.callPackage ./nordvpn {};

  nodeCustomPackages = {
    prettierd = final.callPackage ./prettierd {};
  };

  catppuccin = with final; {
    zathura = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "zathura";
      rev = "b409a2077744e612f61d2edfd9efaf972e155c5f";
      hash = "sha256-qfnx8e+T2A8DXPm/cnJPtUAPdx/6JKs40mgUjn1ptC8=";
    };
    btop = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "btop";
      rev = "ecb8562bb6181bb9f2285c360bbafeb383249ec3";
      hash = "sha256-ovVtupO5jWUw6cwA3xEzRe1juUB8ykfarMRVTglx3mk=";
    };
    discocss = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "discord";
      rev = "fbcbf91afee3f22ee0e46fc6776fcebbb906b06d";
      hash = "sha256-VR+eK3HLTVExQcPdQAyZIYyPzZWYF0hjXTOdXrt9T1g=";
    };
    bat = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "bat";
      rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
      hash = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
    };
    alacritty = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "alacritty";
      rev = "406dcd431b1e8866533798d10613cdbab6568619";
      hash = "sha256-RyxD54fqvs0JK0hmwJNIcW22mhApoNOgZkyhFCVG6FQ=";
    };

    grub-mocha = final.callPackage ./grub-catppuccin-mocha {};
  };

  discord = prev.discord.override {withOpenASAR = true;};
  awesome-git =
    (prev.awesome.override
      {
        gtk3Support = true;
      })
    .overrideAttrs (old: {
      patches = [];
      cmakeFlags = old.cmakeFlags ++ ["-DGENERATE_MANPAGES=OFF"];
      version = "aa8c7c6e27a20fa265d3f06c5dc3fe72cc5f021e";
      src = final.fetchFromGitHub {
        owner = "awesomeWM";
        repo = "awesome";
        rev = "aa8c7c6e27a20fa265d3f06c5dc3fe72cc5f021e";
        fetchSubmodules = false;
        sha256 = "sha256-DGAImB4u8sRP9PEoZ4YXAxopa8eaJ7YJxSiBh36yfaE=";
      };

      postPatch = ''
        patchShebangs tests/examples/_postprocess.lua
        patchShebangs tests/examples/_postprocess_cleanup.lua
      '';
    });

  picom-git = prev.picom.overrideAttrs (old: {
    pname = "picom-git";
    version = "fbc803b9839c19a65c6c46421147c29b46f446fb";
    src = final.fetchFromGitHub {
      owner = "yshui";
      repo = "picom";
      rev = "fbc803b9839c19a65c6c46421147c29b46f446fb";
      fetchSubmodules = false;
      sha256 = "sha256-OamLuacizek/6nEBPSUj3wOzHuuxZJdowRaXIlBAu94=";
    };
    buildInputs =
      (old.buildInputs or [])
      ++ [
        final.pcre2
        final.xorg.xcbutil
      ];
  });

  picom-pijulius = prev.picom.overrideAttrs (old: {
    pname = "picom-pijulius";
    version = "982bb43e5d4116f1a37a0bde01c9bda0b88705b9";
    src = final.fetchFromGitHub {
      owner = "pijulius";
      repo = "picom";
      rev = "982bb43e5d4116f1a37a0bde01c9bda0b88705b9";
      fetchSubmodules = false;
      sha256 = "sha256-YiuLScDV9UfgI1MiYRtjgRkJ0VuA1TExATA2nJSJMhM=";
    };
    buildInputs =
      (old.buildInputs or [])
      ++ [
        final.pcre2
        final.xorg.xcbutil
      ];
  });
}
