{ config, pkgs, inputs, ... }:

{
  users.users.kon8522 = {
    home = "/Users/kon8522";
    isHidden = false;
    shell = pkgs.zsh;
  };

  nix.package = pkgs.nixFlakes; # NOTE: EXPERIMENTAL.

  home-manager.users.kon8522 = import ./home.nix { inherit config pkgs inputs; };

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

  system.stateVersion = 4;
}
