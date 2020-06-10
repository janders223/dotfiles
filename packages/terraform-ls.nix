{ stdenv, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "terraform-ls";
  version = "0.3.2";

  src = fetchFromGitHub {
    rev = "v${version}";
    owner = "hashicorp";
    repo = "terraform-ls";
    sha256 = "11776nq1ixrg791xlmryjxldsc8gn69j1fc0wd6cdywy8yp2lh4w";
  };

  modRoot = ".";
  vendorSha256 = null;

  meta = with stdenv.lib; {
    description = "terraform language server";
    homepage = "https://github.com/hashicorp/terraform-ls";
    platforms = platforms.darwin;
  };
}
