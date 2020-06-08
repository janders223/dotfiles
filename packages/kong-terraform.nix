{ stdenv ? (import <nixpkgs> { }).stdenv
, fetchurl ? (import <nixpkgs> { }).fetchurl
, unzip ? (import <nixpkgs> { }).unzip }:

stdenv.mkDerivation rec {
  pname = "terraform-provider-kong";
  version = "5.2.1";

  src = fetchurl {
    url =
      "https://github.com/kevholditch/terraform-provider-kong/releases/download/v${version}/terraform-provider-kong_${version}_darwin_amd64.zip";
    sha256 = "0akpf0naj8njbja68fgp8zwk283fxdlsmvw9arn45xl4h4nqj9cg";
  };

  buildInputs = [ unzip ];

  installPhase = ''
    mkdir -p "$out/.terraform.d/plugins"
    ls -halF
    cp -pR * $out/.terraform.d/plugins/${pname}_v${version}
  '';

  meta = with stdenv.lib; {
    description = "Terraform Kong Provider";
    homepage = "https://github.com/kevholditch/terraform-provider-kong";
    platforms = platforms.darwin;
  };
}
