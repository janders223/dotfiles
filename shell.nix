{ pkgs }:

with pkgs;

mkShell {
  buildInputs = [
    lua
    nixpkgs-fmt
    nodePackages.vim-language-server
    rnix-lsp
  ];
}
