{ config, pkgs, ... }:

let
  home_directory = builtins.getEnv "HOME";
  notmuchrc = "${home_directory}/.config/notmuch/notmuchrc";

  callPackage = pkgs.callPackage;

in {
  imports = [ <home-manager/nix-darwin> ./home.nix ];
  home-manager.useUserPackages = true;

  users.users.kon8522 = {
    home = "/Users/kon8522";
    description = "Jim Anders";
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    afew
    ansible_2_9
    cacert
    clojure
    clojure-lsp
    coreutils
    curl
    direnv
    editorconfig-core-c
    emacs
    fd
    fontconfig
    git
    gitlab-runner
    gnumake
    gnupg
    gnutls
    gocode
    golangci-lint
    gomodifytags
    gotests
    hugo
    imagemagick
    isync
    jq
    leiningen
    nix-zsh-completions
    nixfmt
    nixops
    nodejs-14_x
    notmuch
    packer
    pandoc
    pinentry_mac
    python37Packages.passlib
    ripgrep
    rustup
    shellcheck
    sqlite
    terraform
    terraform-lsp
    wget
    yarn
    youtube-dl
    zsh
    zstd

    (callPackage ./packages/docker.nix { })
    (callPackage ./packages/dockfmt.nix { })
    (callPackage ./packages/doom.nix { })
    (callPackage ./packages/firefox.nix { })
    (callPackage ./packages/gore.nix { })
    (callPackage ./packages/goreleaser.nix { })
    (callPackage ./packages/guru.nix { })
    (callPackage ./packages/hammerspoon.nix { })
    # (callPackage ./packages/kong-terraform.nix { })
    (callPackage ./packages/kya.nix { })
    (callPackage ./packages/spectacle.nix { })
    (callPackage ./packages/spike.nix { })
    # (callPackage ./packages/vlc.nix { })

    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.prettier
    nodePackages.typescript-language-server
    nodePackages.yaml-language-server
  ];

  documentation = {
    enable = true;
    info.enable = true;
    man.enable = true;
  };

  environment.pathsToLink = [ "/bin" "/info" ];
  environment.extraOutputsToInstall = [ "info" ];

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
  system.defaults.NSGlobalDomain."com.apple.mouse.tapBehavior" = null;
  system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = true;

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

  programs.info.enable = true;
  programs.man.enable = true;

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

  environment.etc."ansible/hosts".text = ''
    main.janders223.com
  '';

  nix.maxJobs = 8;
  nix.buildCores = 8;
}
