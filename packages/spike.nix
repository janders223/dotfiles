{ stdenv ? (import <nixpkgs> { }).stdenv
, fetchurl ? (import <nixpkgs> { }).fetchurl
, unzip ? (import <nixpkgs> { }).unzip }:

let appName = "Spike";

in stdenv.mkDerivation rec {
	pname = "spike";
	version = "1.2.0";

	src = fetchurl {
		url = "https://www.spikeproxy.com/updates/Spike-latest.zip";
		sha256 = "037yws2jv7bcym31z0xfgcyn8m0g4rn3ipfqizkvhm1xi5ix78v6";
	};

	buildInputs = [ unzip ];

	installPhase = ''
		mkdir -p "$out/Applications/${appName}.app"
		cp -pR * "$out/Applications/${appName}.app"
		'';

	meta = with stdenv.lib; {
		description = "Spike Proxy";
		homepage = "https://spikeproxy.com";
		platforms = platforms.darwin;
	};
}
