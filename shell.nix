{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell {
  buildInputs = [
    nixpkgs-fmt
    rnix-lsp
  ];
}
