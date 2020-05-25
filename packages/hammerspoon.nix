{ stdenv ? (import <nixpkgs> { }).stdenv
, fetchurl ? (import <nixpkgs> { }).fetchurl
, unzip ? (import <nixpkgs> { }).unzip }:

let appName = "hammerspoon";

in stdenv.mkDerivation rec {
  pname = "hammerspoon";
  version = "0.9.78";

  src = fetchurl {
    url =
      "https://github.com/Hammerspoon/hammerspoon/releases/download/${version}/Hammerspoon-${version}.zip";
    sha256 = "1zz5sbf2cc7qc90c8f56ksq87wx70akjy5nia0jsfhzvqmw8lsm0";
  };

  buildInputs = [ unzip ];

  installPhase = ''
    mkdir -p "$out/Applications/${appName}.app"
    cp -pR * "$out/Applications/${appName}.app"
  '';

  meta = with stdenv.lib; {
    description = "This is a tool for powerful automation of OS X";
    homepage = "https://www.hammerspoon.org";
    platforms = platforms.darwin;
  };
}
