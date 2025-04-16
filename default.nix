{
  pkgs ? import <nixpkgs> {},
}:
let
  stdenv = pkgs.stdenv;
  lib = pkgs.lib;
  fetchurl = pkgs.fetchurl;
  autoPatchelfHook = pkgs.autoPatchelfHook;
  libgcc = pkgs.libgcc;
in 
stdenv.mkDerivation {
  pname = "spacetimedb";
  version = "1.0.1";
  src = fetchurl {
    url = "https://github.com/clockworklabs/SpacetimeDB/releases/download/v1.1.0/spacetime-x86_64-unknown-linux-gnu.tar.gz";
    hash = "sha256-t7V4TkPWQfzH8PUkRLq1OMaKhZ4in4EZCLKinc2oSik=";
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
