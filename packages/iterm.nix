{ stdenv ? (import <nixpkgs> { }).stdenv
, fetchurl ? (import <nixpkgs> { }).fetchurl
, unzip ? (import <nixpkgs> { }).unzip }:

let appName = "iTerm2";

in stdenv.mkDerivation rec {
	pname = "iterm";
	version = "3_3_10";

	src = fetchurl {
    url = "https://iterm2.com/downloads/stable/iTerm2-${version}.zip";
    sha256 = "181lypcjjjjcya3zdssawq2lnl277qi74ihw1s02sbcl17ayql7c";
  };

	buildInputs = [ unzip ];

	installPhase = ''
		mkdir -p "$out/Applications/${appName}.app"
		cp -pR * "$out/Applications/${appName}.app"
		'';

	meta = with stdenv.lib; {
		description = "iTerm2";
		homepage = https://iterm2.com;
		platforms = platforms.darwin;
	};
}
