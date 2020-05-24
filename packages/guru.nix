{ stdenv, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "guru";
  version = "0.4.1";

  src = fetchFromGitHub {
    rev = "967c0548402963b48559b96114c50954ecde7225";
    owner = "golang";
    repo = "tools";
    sha256 = "18migk7arxm8ysfzidl7mdr069fxym9bfi6zisj7dliczw0qnkzv";
  };

  subPackages = [ "cmd/guru" ];

  modRoot = ".";
  vendorSha256 = "0pplmqxrnc8qnr5708igx4dm7rb0hicvhg6lh5hj8zkx38nb19s0";

  meta = with stdenv.lib; {
    description = "A tool for answering questions about Go source code.";
    homepage = "https://github.com/golang/tools";
    license = [ licenses.mit ];
    # maintainers = [ maintainers.twey maintainers.marsam ];
  };
}
