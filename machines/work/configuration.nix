{ config, pkgs, ... }:
let
  vimrc = import ../../vim/vimrc.nix { };
  vimPackages = import ../../vim/vim.nix { inherit pkgs; };
  globalPackages = import ../packages.nix { inherit pkgs; };
  bin = import ../../bin { inherit pkgs; };


in
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
    with pkgs; [
      config.programs.vim.package

      direnv
      fzf
      gitAndTools.gitFull
      hasklig
      starship
    ] ++ globalPackages
    ++ bin;

  nix.package = pkgs.nixFlakes; # NOTE: EXPERIMENTAL.

  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;

  programs.bash.enableCompletion = true;

  programs.tmux.enable = true;
  programs.tmux.enableSensible = true;
  programs.tmux.enableMouse = true;
  programs.tmux.enableFzf = true;
  programs.tmux.enableVim = true;

  programs.tmux.extraConfig = import ../../tmux/tmux.nix { inherit pkgs; };

  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.enableBashCompletion = true;
  programs.zsh.enableFzfCompletion = true;
  programs.zsh.enableFzfGit = true;
  programs.zsh.enableFzfHistory = true;

  programs.zsh.loginShellInit = ''
    eval "$(starship init zsh)"

    eval "$(direnv hook zsh)"

    if [ -z "$TMUX" ]; then
      tmux attach -t default || tmux new -s default
    fi

    ls() {
      ${pkgs.coreutils}/bin/ls --color=auto "$@"
    }
  '';

  programs.vim.package = pkgs.neovim.override {
    configure = {
      packages.darwin.start = vimPackages;
      customRC = vimrc.config;
    };
  };

  environment.loginShell = "${pkgs.zsh}/bin/zsh -l";
  environment.variables.SHELL = "${pkgs.zsh}/bin/zsh";
  environment.variables.ftp_proxy = "http://127.0.0.1:3128";
  environment.variables.http_proxy = "http://127.0.0.1:3128";
  environment.variables.https_proxy = "http://127.0.0.1:3128";
  environment.variables.FTP_PROXY = "http://127.0.0.1:3128";
  environment.variables.HTTP_PROXY = "http://127.0.0.1:3128";
  environment.variables.HTTPS_PROXY = "http://127.0.0.1:3128";
  environment.variables.EDITOR = "nvim";
  environment.variables.LANG = "en_US.UTF-8";

  environment.shellAliases.l = "ls -halF";
  environment.shellAliases.vim = "nvim";

  system.stateVersion = 4;
}
