{
  lib,
  fetchurl,
  makeDesktopItem,
  symlinkJoin,
  writeShellScriptBin,
  jdk,
  ...
}
: let
  pname = "TLauncher";
  version = "2.86";

  src = fetchurl rec {
    name = "TLauncher-${lib.strings.sanitizeDerivationName sha256}.jar";
    url = "https://tlaun.ch/jar";
    sha256 = "sha256-Uef9RAuPwMt6yo6cOg3878RzLH2UPUX/y+QO937FHNE=";
  };

  desktopItems = makeDesktopItem {
    name = pname;
    exec = pname;
    inherit icon;
    comment = "Minecraft Launcher";
    desktopName = "TLauncher";
    categories = ["Game"];
  };

  icon = ./TLauncher.svg;

  script = writeShellScriptBin pname ''
    ${jdk}/bin/java -jar ${src}
  '';
in
  symlinkJoin {
    name = "${pname}-${version}";
    paths = [desktopItems script];

    meta = {
      description = "Minecraft Launcher";
      homepage = "https://tlaun.ch";
      maintainers = [lib.maintainers.fufexan];
      platforms = lib.platforms.linux;
    };
  }
