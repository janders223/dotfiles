{ stdenv ? (import <nixpkgs> { }).stdenv
, fetchurl ? (import <nixpkgs> { }).fetchurl
, undmg ? (import <nixpkgs> { }).undmg }:

let appName = "Firefox";

in stdenv.mkDerivation rec {
	pname = "firefox";
	version = "76.0";

	src = fetchurl {
	    name = "Firefox-${version}.dmg";
	    url = "https://download-installer.cdn.mozilla.net/pub/firefox/releases/${version}/mac/en-US/Firefox%20${version}.dmg";
	    sha256 = "03bbx1bd877azy8n86g3lbfzy78yrg67ndhg66gcsy5w730487y7";
	};

	buildInputs = [ undmg ];

	installPhase = ''
		mkdir -p "$out/Applications/${appName}.app"
		cp -pR * "$out/Applications/${appName}.app"
		'';

	meta = with stdenv.lib; {
		description = "The Firefox web browser";
		homepage = https://www.mozilla.org/en-US/firefox/;
		platforms = platforms.darwin;
	};
}
