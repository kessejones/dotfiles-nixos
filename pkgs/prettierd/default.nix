{
  pkgs,
  mkYarnPackage,
  fetchFromGitHub,
  ...
}:
mkYarnPackage rec {
  pname = "prettierd";
  version = "0.23.3";
  src = fetchFromGitHub {
    owner = "fsouza";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-M9VA67Ix2aKS5V0cA0cFPXkASoAyFxW6rEopSYXtyiA=";
  };

  buildPhase = ''
    export HOME=$(mktemp -d)
    yarn --offline build
  '';

  distPhase = "true";

  meta = {
    description = "prettier, as a daemon";
    homepage = "https://github.com/fsouza/prettierd";
    license = "ISC";
  };
}
