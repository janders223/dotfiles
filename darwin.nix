{ config, pkgs ? import (fetchTarball
  "https://github.com/NixOS/nixpkgs/archive/2cd2e7267e5b9a960c2997756cb30e86f0958a6b.tar.gz")
  { }, ... }:

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

  documentation = {
    enable = true;
    info.enable = true;
    man.enable = true;
  };

  environment.systemPackages = with pkgs; [
    afew
    cacert
    coreutils
    curl
    direnv
    editorconfig-core-c
    emacs
    fd
    fontconfig
    git
    gitlab-runner
    gnupg
    gnutls
    imagemagick
    isync
    jq
    lorri
    nix-zsh-completions
    nixfmt
    nixops
    notmuch
    (pass.withExtensions
      (ext: with ext; [ pass-otp pass-audit pass-genphrase ]))
    pinentry_mac
    python37Packages.passlib
    ripgrep
    wget
    youtube-dl
    zsh
    zstd

    (callPackage ./packages/docker.nix { })
    (callPackage ./packages/firefox.nix { })
    (callPackage ./packages/hammerspoon.nix { })
    (callPackage ./packages/spike.nix { })
  ];
  environment.pathsToLink = [ "/bin" "/info" ];
  environment.extraOutputsToInstall = [ "info" ];
  environment.shells = [ pkgs.zsh ];

  fonts = {
    enableFontDir = true;

    fonts = with pkgs; [ hasklig ];
  };

  system.defaults.NSGlobalDomain = {
    AppleKeyboardUIMode = 3;
    ApplePressAndHoldEnabled = false;
    InitialKeyRepeat = 10;
    KeyRepeat = 1;
    NSAutomaticCapitalizationEnabled = false;
    NSAutomaticDashSubstitutionEnabled = false;
    NSAutomaticPeriodSubstitutionEnabled = false;
    NSAutomaticQuoteSubstitutionEnabled = false;
    NSAutomaticSpellingCorrectionEnabled = false;
    _HIHideMenuBar = true;
    NSTableViewDefaultSizeMode = 2;
    AppleShowScrollBars = "Automatic";
    NSUseAnimatedFocusRing = false;
    NSWindowResizeTime = "0.001";
    NSNavPanelExpandedStateForSaveMode = true;
    NSNavPanelExpandedStateForSaveMode2 = true;
    PMPrintingExpandedStateForPrint = true;
    PMPrintingExpandedStateForPrint2 = true;
    NSTextShowsControlCharacters = true;
    NSDisableAutomaticTermination = true;
    AppleShowAllExtensions = true;
    "com.apple.mouse.tapBehavior" = null;
    "com.apple.swipescrolldirection" = true;
  };

  system.defaults.LaunchServices.LSQuarantine = false;

  system.defaults.dock = {
    autohide = true;
    mru-spaces = false;
    orientation = "left";
    showhidden = true;
  };

  system.defaults.finder = {
    AppleShowAllExtensions = true;
    QuitMenuItem = true;
    FXEnableExtensionChangeWarning = false;
  };

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;

  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  services.yabai = {
    enable = true;
    package = pkgs.yabai;
    enableScriptingAddition = true;
    config = {
      layout = "bsp";
      window_opacity = "off";
      top_padding = 10;
      bottom_padding = 10;
      left_padding = 10;
      right_padding = 10;
      window_gap = 10;
    };
  };

  services.skhd = {
    enable = true;
    skhdConfig = ''
      # Focus Windows
      alt - h : yabai -m window --focus west
      alt - j : yabai -m window --focus north
      alt - k : yabai -m window --focus south
      alt - l : yabai -m window --focus east

      # swap managed window
      shift + alt - h : yabai -m window --swap west
      shift + alt - j : yabai -m window --swap south
      shift + alt - k : yabai -m window --swap north
      shift + alt - l : yabai -m window --swap east
    '';
  };

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
    lorri = {
      serviceConfig = {
        WorkingDirectory = (builtins.getEnv "HOME");
        EnvironmentVariables = { };
        KeepAlive = true;
        RunAtLoad = true;
        StandardOutPath = "/var/tmp/lorri.log";
        StandardErrorPath = "/var/tmp/lorri.log";
      };
      script = ''
        source ${config.system.build.setEnvironment}
        exec ${pkgs.lorri}/bin/lorri daemon
      '';
    };
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
