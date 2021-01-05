{ config, pkgs, ... }:

{
  system.defaults = {
    NSGlobalDomain = {
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

    dock = {
      autohide = true;
      mru-spaces = false;
      orientation = "left";
      showhidden = true;
    };

    finder = {
      AppleShowAllExtensions = true;
      QuitMenuItem = true;
      FXEnableExtensionChangeWarning = false;
    };

    LaunchServices.LSQuarantine = false;
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

  fonts = {
    enableFontDir = true;

    fonts = with pkgs; [ hasklig ];
  };
  environment.systemPackages =
    [
      config.programs.vim.package

      pkgs.direnv
      pkgs.fzf
      pkgs.hasklig
      pkgs.ripgrep
      pkgs.starship
    ];

    nix.package = pkgs.nixFlakes; # NOTE: EXPERIMENTAL.

    environment.darwinConfig = "$HOME/src/dotfiles-redux/configuration.nix";

    programs.gnupg.agent.enable = true;
    programs.gnupg.agent.enableSSHSupport = true;

    programs.bash.enableCompletion = true;

    programs.tmux.enable = true;
    programs.tmux.enableSensible = true;
    programs.tmux.enableMouse = true;
    programs.tmux.enableFzf = true;
    programs.tmux.enableVim = true;

    programs.tmux.extraConfig = builtins.readFile ../../tmux/tmux.conf;

    programs.zsh.enable = true;
    programs.zsh.enableBashCompletion = true;
    programs.zsh.enableFzfCompletion = true;
    programs.zsh.enableFzfGit = true;
    programs.zsh.enableFzfHistory = true;

    programs.zsh.loginShellInit = ''
      eval "$(starship init zsh)"

      eval "$(direnv hook zsh)"

      ls() {
        ${pkgs.coreutils}/bin/ls --color=auto "$@"
      }
    '';

    programs.vim.package = import ../../vim/vim.nix { pkgs = pkgs; };

    environment.loginShell = "${pkgs.zsh}/bin/zsh -l";
    environment.variables.SHELL = "${pkgs.zsh}/bin/zsh";

    environment.variables.LANG = "en_US.UTF-8";

    environment.shellAliases.l = "ls -halF";

    system.stateVersion = 4;
  }
