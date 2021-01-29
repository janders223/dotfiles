{ pkgs }:

with pkgs;

mkShell {
  buildInputs = [
    lua
    ninja
    nixpkgs-fmt
    nodePackages.vim-language-server
    rnix-lsp
  ];
}
