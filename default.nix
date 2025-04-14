{
  stdenv,
  lib,
  fetchurl,
  autoPatchelfHook,
  libgcc,
}:
stdenv.mkDerivation {
  pname = "spacetimedb";
  version = "1.0.1";
  src = fetchurl {
    url = "https://github.com/clockworklabs/SpacetimeDB/releases/download/v1.0.1/spacetime-x86_64-unknown-linux-gnu.tar.gz";
    hash = "sha256-dHxb9hNbQwfww9CJUp6IE4etxro9qvFQGyHOhJMYkV0=";
  };

  nativeBuildInputs = [ autoPatchelfHook ];

  buildInputs = [
    libgcc
    stdenv.cc.cc.lib
  ];

  unpackPhase = ''
    runHook preUnpack
    mkdir -p $out/bin
    tar -xvf $src -C $out/bin
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall
    runHook postInstall
  '';
}
