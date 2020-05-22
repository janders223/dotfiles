{ stdenv ? (import <nixpkgs> { }).stdenv
, fetchurl ? (import <nixpkgs> { }).fetchurl
, undmg ? (import <nixpkgs> { }).undmg }:

let appName = "Brave";

in stdenv.mkDerivation rec {
	pname = "brave";
	version = "1.9.72";

	src = fetchurl {
		url = "https://github.com/brave/brave-browser/releases/download/v${version}/Brave-Browser.dmg";
		sha256 = "0w16g46zgy7g62sgwx9gkn4db1jfavwgx6gfkmf8npkhqx8ahwbx";
	};

	buildInputs = [ undmg ];

	installPhase = ''
		mkdir -p "$out/Applications/${appName}.app"
		cp -pR * "$out/Applications/${appName}.app"
		'';

	meta = with stdenv.lib; {
		description = "Brave Browser";
		homepage = "https://brave.com";
		platforms = platforms.darwin;
	};
}
