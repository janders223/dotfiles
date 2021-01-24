{ pkgs, ... }:

with pkgs; [
  gitAndTools.hub
  curl
  ripgrep
]
