{ stdenv, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "dockfmt";
  version = "0.3.3";

  src = fetchFromGitHub {
    rev = "v${version}";
    owner = "jessfraz";
    repo = "dockfmt";
    sha256 = "0m56ydmf7zbcsa5yym7j5fgr75v677h9s40zyzwrqccyq01myp06";
  };

  modRoot = ".";
  vendorSha256 = null;

  meta = with stdenv.lib; {
    description = "Like `gofmt` but for Dockerfiles.";
    homepage = "https://github.com/jessfraz/dockfmt";
    license = [ licenses.mit ];
  };
}
