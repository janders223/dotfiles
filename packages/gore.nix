{ stdenv, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "gore";
  version = "0.5.0";

  src = fetchFromGitHub {
    rev = "v${version}";
    owner = "motemen";
    repo = "gore";
    sha256 = "0kiqf0a2fg6759byk8qbzidc9nx13rajd3f5bx09n19qbgfyflgb";
  };

  modRoot = ".";
  vendorSha256 = "05jyfgpvsiiimphpqiv17dm0b65bnrljis93b2xxmrcj2aqvmfnx";

  meta = with stdenv.lib; {
    description = "Yet another Go REPL.";
    homepage = "https://github.com/motemen/gore/cmd/gore";
    license = [ licenses.mit ];
  };
}
