
{ stdenv ? (import <nixpkgs> { }).stdenv
, fetchurl ? (import <nixpkgs> { }).fetchurl
, undmg ? (import <nixpkgs> { }).undmg }:

let appName = "Docker";

in stdenv.mkDerivation rec {
	pname = "docker";
	version = "?";

	src = fetchurl {
	    url =   "https://download.docker.com/mac/stable/Docker.dmg";
	    sha256 = "0d9z4fnhlq0y469jdjzid8pkl3vgg636q551v86xximrn9jp667d";
	};

	buildInputs = [ undmg ];

	installPhase = ''
		mkdir -p "$out/Applications/${appName}.app"
		cp -pR * "$out/Applications/${appName}.app"
		'';

	meta = with stdenv.lib; {
		description = "Docker...for Mac";
		homepage =  https://docker.com;
		platforms = platforms.darwin;
	};
}
