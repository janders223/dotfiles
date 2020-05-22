{ config, pkgs, ... }:

let
  callPackage = pkgs.callPackage;

  # brave = callPackage ./packages/brave.nix {};
  docker = callPackage ./packages/docker.nix { };
  doom = callPackage ./packages/doom.nix { };
  firefox = callPackage ./packages/firefox.nix { };
  #goreleaser = callPackage ./packages/goreleaser.nix { };
  iterm = callPackage ./packages/iterm.nix { };
  kya = callPackage ./packages/kya.nix { };
  spectacle = callPackage ./packages/spectacle.nix { };
  spike = callPackage ./packages/spike.nix { };
  # vlc = callPackage ./packages/vlc.nix {};
in {
  imports = [ <home-manager/nix-darwin> ./home.nix ];
  home-manager.useUserPackages = true;

  users.users.kon8522 = {
    home = "/Users/kon8522";
    description = "Jim Anders";
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    # brave
    # vlc
    cacert
    coreutils
    curl
    direnv
    docker
    doom
    emacs
    fd
    firefox
    fontconfig
    git
    gitlab-runner
    gnupg
    golangci-lint
    #goreleaser
    imagemagick
    isync
    iterm
    jq
    kya
    mu
    nixfmt
    packer
    pandoc
    pinentry_mac
    ripgrep
    shellcheck
    spectacle
    spike
    terraform
    wget
    yarn
    youtube-dl
    zsh
  ];

  fonts = {
    enableFontDir = true;

    fonts = with pkgs; [ hasklig ];
  };

  environment.shells = [ pkgs.zsh ];

  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
    allowUnsupportedSystem = false;
  };

  programs.bash.enable = true;
  programs.zsh = {
    enable = true;
    enableFzfCompletion = true;
    enableFzfGit = true;
    enableFzfHistory = true;
    enableSyntaxHighlighting = true;
  };

  system.stateVersion = 4;

  environment.darwinConfig = "$HOME/src/dotfiles/darwin.nix";

  nix.maxJobs = 8;
  nix.buildCores = 8;
}
