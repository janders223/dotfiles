{ stdenv, fetchurl, undmg }:

stdenv.mkDerivation rec {
  pname = "Docker";
  version = "2.3.0.3";

  buildInputs = [ undmg ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];

  src = fetchurl {
    url = "https://download.docker.com/mac/stable/Docker.dmg";
    sha256 = "1md1h3n3n983qarl6f94vjamb697c20w31mk5kk13ixgdgwc4py2";
  };

  installPhase = ''
    mkdir -p "$out/Applications"
    cp -r Docker.app "$out/Applications/Docker.app"
  '';

  meta = with stdenv.lib; {
    description = "Docker...for Mac";
    homepage = "https://docker.com";
    maintainers = [ maintainers.janders223 ];
    platforms = platforms.darwin;
  };
}
