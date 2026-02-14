{
  lib,
  stdenv,
  fetchurl,
  undmg,
  steam-run,
  bash,
}:
stdenv.mkDerivation rec {
  pname = "glide-browser";
  version = "0.1.58a";

  src = fetchurl {
    url = "https://github.com/glide-browser/glide/releases/download/${version}/glide.linux-x86_64.tar.xz";
    sha256 = "sha256-yut/yXT+BJCFackLSRG7tLBD6m008k0lC62Qwt7aRX8=";
  };

  nativeBuildInputs = lib.optionals stdenv.isDarwin [undmg];
  sourceRoot = ".";

  installPhase =
    if stdenv.isLinux
    then ''
      mkdir -p $out/bin $out/lib/glide
      cp -r glide/* $out/lib/glide/
      chmod +x $out/lib/glide/glide

      cat > $out/bin/glide <<EOF
      #!/bin/sh
      cd $out/lib/glide
      exec ${steam-run}/bin/steam-run ${bash}/bin/bash -c "GTK_IM_MODULE=\$GTK_IM_MODULE $out/lib/glide/glide"
      EOF
      chmod +x $out/bin/glide

      cat > $out/bin/glide-browser <<EOF
      #!/bin/sh
      cd $out/lib/glide
      exec ${steam-run}/bin/steam-run ${bash}/bin/bash -c "GTK_IM_MODULE=\$GTK_IM_MODULE $out/lib/glide/glide"
      EOF
      chmod +x $out/bin/glide-browser
    ''
    else ''
      mkdir -p $out/Applications
      cp -r Glide.app $out/Applications/
    '';

  meta = {
    description = "Glide Browser";
    homepage = "https://github.com/glide-browser/glide";
    platforms = [
      "x86_64-linux"
    ];
  };
}
