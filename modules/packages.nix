{ pkgs }:

with pkgs; [
  (pass.withExtensions (ext: with ext; [ pass-otp pass-audit pass-genphrase ]))
  cacert
  coreutils
  curl
  direnv
  Docker
  editorconfig-core-c
  fd
  fontconfig
  git
  gnupg
  gnutls
  imagemagick
  jq
  lorri
  niv
  nix-zsh-completions
  nixfmt
  nixops
  pinentry_mac
  python37Packages.passlib
  ripgrep
  wget
  zbar
  zsh
  zstd
]
