{ pkgs, ... }:

with pkgs; [
  curl
  gcc
  gitAndTools.hub
  llvm
  ripgrep
  tree-sitter
]
