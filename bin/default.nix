{ pkgs, ... }:
let
  tmpd = pkgs.writeScriptBin "tmpd" ''
    #!${pkgs.stdenv.shell}
    dir=$(mktemp -d -t tmp.XXXXXXXXXX)

    cd $dir
  '';

in
[
  tmpd
]
