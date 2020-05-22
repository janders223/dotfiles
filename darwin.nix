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
    aspell
    cacert
    coreutils
    curl
    direnv
    docker
    doom
    editorconfig-core-c
    emacs
    fd
    firefox
    fontconfig
    git
    gitlab-runner
    gnupg
    gnutls
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
    sqlite
    terraform
    terraform-lsp
    wget
    yarn
    youtube-dl
    zsh
    zstd

    nodePackages.dockerfile-language-server-nodejs
    # nodePackages.vscode-json-languageserver
    nodePackages.typescript-language-server
    nodePackages.bash-language-server
    nodePackages.yaml-language-server
  ];

  fonts = {
    enableFontDir = true;

    fonts = with pkgs; [ hasklig ];
  };

  environment.shells = [ pkgs.zsh ];

  system.defaults.NSGlobalDomain.AppleKeyboardUIMode = 3;
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 10;
  system.defaults.NSGlobalDomain.KeyRepeat = 1;
  system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;
  system.defaults.NSGlobalDomain._HIHideMenuBar = true;

  system.defaults.dock.autohide = true;
  system.defaults.dock.mru-spaces = false;
  system.defaults.dock.orientation = "left";
  system.defaults.dock.showhidden = true;

  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder.QuitMenuItem = true;
  system.defaults.finder.FXEnableExtensionChangeWarning = false;

  system.defaults.trackpad.Clicking = true;
  system.defaults.trackpad.TrackpadThreeFingerDrag = true;

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;

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
