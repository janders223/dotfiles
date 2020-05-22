{ stdenv ? (import <nixpkgs> { }).stdenv
, fetchurl ? (import <nixpkgs> { }).fetchurl
, undmg ? (import <nixpkgs> { }).undmg }:

let appName = "VLC";

in stdenv.mkDerivation rec {
	pname = "vlc";
	version = "3.0.10";

	src = fetchurl {
		url = "https://get.videolan.org/vlc/${version}/macosx/vlc-${version}.dmg";
		sha256 = "1bf8hph689s19cnpbaxpcczflaiaylcjq5zriwydinn8fl8hxnff";
	};

	buildInputs = [ undmg ];

	installPhase = ''
		mkdir -p $out/bin
		mkdir -p "$out/Applications/${appName}.app"
		cp -pR * "$out/Applications/${appName}.app"
		'';

	postInstall = ''
	ln -s $out/Applications/${appName}.app/Contents/MacOS/VLC $out/bin
	'';

	meta = with stdenv.lib; {
		description = "VLC media player";
		homepage = https://www.videolan.org/;
		platforms = platforms.darwin;
	};
}
