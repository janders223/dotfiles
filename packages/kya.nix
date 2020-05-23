{ stdenv ? (import <nixpkgs> { }).stdenv
, fetchurl ? (import <nixpkgs> { }).fetchurl
, unzip ? (import <nixpkgs> { }).unzip }:

let appName = "KeepingYouAwake";

in stdenv.mkDerivation rec {
	pname = "keepingyouawake";
	version = "1.5.1";

	src = fetchurl {
	  url = "https://github.com/newmarcel/KeepingYouAwake/releases/download/${version}/KeepingYouAwake-${version}.zip";
	    sha256 = "0890a2k6sc77z3szk63jgjgj098f9ipkg25v40gaaicq8as5n0ls";
	};

	buildInputs = [ unzip ];

	installPhase = ''
		mkdir -p "$out/Applications/${appName}.app"
		cp -pR * "$out/Applications/${appName}.app"
		'';

	meta = with stdenv.lib; {
		description = "Keeping You Awake";
		homepage = https://github.com/newmarcel/KeepingYouAwake;
		platforms = platforms.darwin;
	};
}
