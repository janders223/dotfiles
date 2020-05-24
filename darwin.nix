{ config, pkgs, ... }:

let
  home_directory = builtins.getEnv "HOME";
  notmuchrc = "${home_directory}/.config/notmuch/notmuchrc";

  callPackage = pkgs.callPackage;

  # brave = callPackage ./packages/brave.nix {};
  docker = callPackage ./packages/docker.nix { };
  doom = callPackage ./packages/doom.nix { };
  firefox = callPackage ./packages/firefox.nix { };
  gore = callPackage ./packages/gore.nix { };
  guru = callPackage ./packages/guru.nix { };
  goreleaser = callPackage ./packages/goreleaser.nix { };
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
    afew
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
    gocode
    golangci-lint
    gomodifytags
    gore
    gotests
    guru
    goreleaser
    imagemagick
    isync
    iterm
    jq
    kya
    nixfmt
    notmuch
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
  system.defaults.NSGlobalDomain._HIHideMenuBar = true;
  system.defaults.NSGlobalDomain.NSTableViewDefaultSizeMode = 2;
  system.defaults.NSGlobalDomain.AppleShowScrollBars = "Automatic";
  system.defaults.NSGlobalDomain.NSUseAnimatedFocusRing = false;
  system.defaults.NSGlobalDomain.NSWindowResizeTime = "0.001";
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;
  system.defaults.NSGlobalDomain.PMPrintingExpandedStateForPrint = true;
  system.defaults.NSGlobalDomain.PMPrintingExpandedStateForPrint2 = true;
  system.defaults.NSGlobalDomain.NSTextShowsControlCharacters = true;
  system.defaults.NSGlobalDomain.NSDisableAutomaticTermination = true;
  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;

  system.defaults.LaunchServices.LSQuarantine = false;

  system.defaults.dock.autohide = true;
  system.defaults.dock.mru-spaces = false;
  system.defaults.dock.orientation = "left";
  system.defaults.dock.showhidden = true;

  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder.QuitMenuItem = true;
  system.defaults.finder.FXEnableExtensionChangeWarning = false;

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
    enableCompletion = true;
    enableBashCompletion = true;
    enableFzfCompletion = true;
    enableFzfGit = true;
    enableFzfHistory = true;
    enableSyntaxHighlighting = true;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  system.stateVersion = 4;

  environment.darwinConfig = "$HOME/src/dotfiles/darwin.nix";

  launchd.user.agents = {
    mbsync = {
      script = ''
        ${pkgs.afew}/bin/afew -C ${notmuchrc} --move-mails --verbose
        ${pkgs.isync}/bin/mbsync --all
        ${pkgs.notmuch}/bin/notmuch new
      '';
      environment = { NOTMUCH_CONFIG = "${notmuchrc}"; };
      serviceConfig.StartInterval = 900;
      serviceConfig.RunAtLoad = true;
      serviceConfig.KeepAlive = true;
    };
  };

  nix.maxJobs = 8;
  nix.buildCores = 8;
}
