{ stdenv, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "goreleaser";
  version = "0.136.0";

  src = fetchFromGitHub {
    rev = "v${version}";
    owner = "goreleaser";
    repo = "goreleaser";
    sha256 = "0fa01cxfkaafyndqnpdiivv5p1bfyfp5r374wh2b2a0xrdadz3bf";
  };

  modRoot = ".";
  vendorSha256 = "0dikqp8rfvlf70cvflm8b87kh3b581z1yr63gyv891g9f525k299";

  meta = with stdenv.lib; {
    description = "Deliver Go binaries as fast and easily as possible.";
    homepage = "https://goreleaser.com/";
    license = [ licenses.mit ];
    # maintainers = [ maintainers.twey maintainers.marsam ];
  };
}
