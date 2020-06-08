{ stdenv ? (import <nixpkgs> { }).stdenv
, fetchurl ? (import <nixpkgs> { }).fetchurl
, undmg ? (import <nixpkgs> { }).undmg }:

let appName = "Firefox";

in stdenv.mkDerivation rec {
  pname = "firefox";
  version = "77.0.1";

  src = fetchurl {
    name = "Firefox-${version}.dmg";
    url =
      "https://download-installer.cdn.mozilla.net/pub/firefox/releases/${version}/mac/en-US/Firefox%20${version}.dmg";
    sha256 = "1i9fy8mqz5p71w2ms7ym8q6xwbq162blqm6l5rl36iv44hwdj5l8";
  };

  buildInputs = [ undmg ];

  installPhase = ''
    mkdir -p "$out/Applications/${appName}.app"
    cp -pR * "$out/Applications/${appName}.app"
  '';

  meta = with stdenv.lib; {
    description = "The Firefox web browser";
    homepage = "https://www.mozilla.org/en-US/firefox/";
    platforms = platforms.darwin;
  };
}
