{ stdenv ? (import <nixpkgs> { }).stdenv
, fetchurl ? (import <nixpkgs> { }).fetchurl
, unzip ? (import <nixpkgs> { }).unzip }:

let appName = "Spectacle";

in stdenv.mkDerivation rec {
	pname = "spectacle";
	version = "1.2";

	src = fetchurl {
		url = "https://s3.amazonaws.com/spectacle/downloads/Spectacle+1.2.zip";
		sha256 = "037kayakprzvs27b50r260lwh2r9479f2pd221qmdv04nkrmnvbn";
	};

	buildInputs = [ unzip ];

	installPhase = ''
		mkdir -p "$out/Applications/${appName}.app"
		cp -pR * "$out/Applications/${appName}.app"
		'';

	meta = with stdenv.lib; {
		description = "Spectacle window manager";
		homepage = "https://www.spectacleapp.com/";
		platforms = platforms.darwin;
	};
}
