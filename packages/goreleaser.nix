{ stdenv, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "goreleaser";
  version = "0.135.0";

  src = fetchFromGitHub {
    rev = "v${version}";
    owner = "goreleaser";
    repo = "goreleaser";
    sha256 = "1apb4rcqgbxad4sj946g4gn127zpr19xs9326xb85nryfhlxkfdm";
  };

  subPackages = [ "." ];

  meta = with stdenv.lib; {
    description = "Deliver Go binaries as fast and easily as possible.";
    homepage = "https://goreleaser.com/";
    license = [ licenses.mit ];
    # maintainers = [ maintainers.twey maintainers.marsam ];
  };
}
