{ pkgs }:

with pkgs; [
  aspell
  aspellDicts.en
  aspellDicts.en-computers
  cacert
  coreutils
  curl
  Docker
  editorconfig-core-c
  fd
  fontconfig
  gnupg
  gnutls
  graphviz
  imagemagick
  jq
  lorri
  niv
  nix-zsh-completions
  nixfmt
  pinentry_mac
  python37Packages.passlib
  ripgrep
  units
  wget
  zbar
  zstd
]
