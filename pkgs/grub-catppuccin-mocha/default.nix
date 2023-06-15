{
  stdenv,
  fetchFromGitHub,
  ...
}:
stdenv.mkDerivation rec {
  name = "catppuccin-mocha-grub-theme";
  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "grub";
    rev = "4f6ac653004286a96df39ec6f0c9cabd8d14ee87";
    hash = "sha256-aJSsAJxG3DUvMpWR2wCpMAf8OYW8j9sO7+Hmzvw3z2M=";
  };

  installPhase = ''
    mkdir -p $out
    cp -r src/${name}/* $out/
  '';
}
