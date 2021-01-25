{ pkgs, ... }:

with pkgs; [
  gcc
  gitAndTools.hub
  curl
  ripgrep
  tree-sitter
]
