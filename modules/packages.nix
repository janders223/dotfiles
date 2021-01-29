{ pkgs, ... }:

with pkgs; [
    curl
    exa
    fd
    gcc
    gitAndTools.hub
    llvm
    ripgrep
    tree-sitter
]
