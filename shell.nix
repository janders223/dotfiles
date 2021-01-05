{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell {
  buildInputs = [
    dhall
    nixpkgs-fmt
  ];
}
