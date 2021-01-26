{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell {
  buildInputs = [
    lua
    nixpkgs-fmt
    rnix-lsp
  ];
}
