{ config, lib, ... }:

let

  sources = import ../nix/sources.nix;

  pkgs = import sources.nixpkgs {
    overlays = [ (import ../overlays) ];
    config = {
      allowUnfree = true;
      allowBroken = false;
      allowUnsupportedSystem = false;
    };

    config.packageOverrides = pkgs: {
      nur = import sources.NUR { inherit pkgs; };
    };
  };

  cfg = config.local;

  homeDir = builtins.getEnv "HOME";

in with pkgs.stdenv;
with lib; {
  options.local = with types; {
    userName = mkOption {
      type = str;
      default = "janders223";
      description = "Username";
    };

    userEmail = mkOption {
      type = str;
      default = "jimanders223@gmail.com";
      description = "User e-mail";
    };

    machineName = mkOption {
      type = types.str;
      description = "Target system to build.";
    };
  };

  config = {
    system.stateVersion = 4;
    services.nix-daemon.enable = true;
    nix.maxJobs = 8;
    nix.buildCores = 8;
    nix.package = pkgs.nix;

    nix.trustedUsers = [ "root" cfg.userName ];

    environment.shells = [ pkgs.zsh ];
    # environment.systemPackages = [ pkgs.zsh pkgs.gcc ];
    programs.bash.enable = false;
    programs.zsh.enable = false;
    environment.darwinConfig =
      "${homeDir}/src/dotfiles/machines/${cfg.machineName}/configuration.nix";

    networking.hostName = cfg.machineName;

    time.timeZone = "America/New_York";
    users.users."${cfg.userName}" = {
      shell = pkgs.zsh;
      home = homeDir;
    };

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

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

    services.yabai = {
      enable = true;
      package = pkgs.yabai;
      enableScriptingAddition = true;
      config = {
        layout = "bsp";
        window_opacity = "off";
        top_padding = 30;
        bottom_padding = 10;
        left_padding = 10;
        right_padding = 10;
        window_gap = 10;
      };
      extraConfig = "";
    };

    services.spacebar.enable = true;
    services.spacebar.package = pkgs.spacebar;
    services.spacebar.config = {
      text_font = ''"Menlo:Bold:14.0"'';
      icon_font = ''"FontAwesome:Regular:14.0"'';
      background_color = "0xFF2E3440";
      foreground_color = "0xFFD8DEE9";
      space_icon_color = "0xFF2E3440";
      power_icon_strip = " ";
      space_icon = "";
      clock_icon = "";
    };

    services.skhd = {
      enable = true;
      skhdConfig = builtins.readFile ../config/skhd.conf;
    };

    launchd.user.agents = {
      emacs = {
        serviceConfig.ProgramArguments =
          [ "${pkgs.Emacs}/bin/emacs" "--daemon" ];
        serviceConfig.RunAtLoad = true;
      };
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
    };

    # Recreate /run/current-system symlink after boot
    services.activate-system.enable = true;

    home-manager.users."${cfg.userName}" = {
      home.packages = (import ./packages.nix { inherit pkgs; });

      home.sessionVariables = {
        PAGER = "less -R";
        EDITOR = "emacsclient";
        ftp_proxy = "http://127.0.0.1:3128";
        http_proxy = "http://127.0.0.1:3128";
        https_proxy = "http://127.0.0.1:3128";
        FTP_PROXY = "http://127.0.0.1:3128";
        HTTP_PROXY = "http://127.0.0.1:3128";
        HTTPS_PROXY = "http://127.0.0.1:3128";

        PATH = "$PATH:${pkgs.coreutils}/bin";
      };

      programs.alacritty = {
        enable = true;
        settings = {
          window.padding.x = 15;
          window.padding.y = 15;
          window.decorations = "buttonless";
          scrolling.history = 100000;
          live_config_reload = true;
          selection.save_to_clipboard = true;
          dynamic_title = false;
          mouse.hide_when_typing = true;

          font = {
            normal.family = "Hasklig";
            size = 18;
          };

          colors = {
            primary.background = "0x2E3440";
            primary.foreground = "0xD8DEE9";

            cursor = {

              text = "0x2E3440";
              cursor = "0xD8DEE9";
            };
            normal = {
              black = "0x3B4252";
              red = "0xBF616A";
              green = "0xA3BE8C";
              yellow = "0xEBCB8B";
              blue = "0x81A1C1";
              magenta = "0xB48EAD";
              cyan = "0x88C0D0";
              white = "0xE5E9F0";
            };

            bright = {
              black = "0x4C566A";
              red = "0xBF616A";
              green = "0xA3BE8C";
              yellow = "0xEBCB8B";
              blue = "0x81A1C1";
              magenta = "0xB48EAD";
              cyan = "0x8FBCBB";
              white = "0xECEFF4";
            };
          };

          # key_bindings = [
          #   {
          #     key = "V";
          #     mods = "Command";
          #     action = "Paste";
          #   }
          #   {
          #     key = "C";
          #     mods = "Command";
          #     action = "Copy";
          #   }
          #   {
          #     key = "Q";
          #     mods = "Command";
          #     action = "Quit";
          #   }
          #   {
          #     key = "Q";
          #     mods = "Control";
          #     chars = "\\x11";
          #   }
          #   {
          #     key = "F";
          #     mods = "Alt";
          #     chars = "\\x1bf";
          #   }
          #   {
          #     key = "B";
          #     mods = "Alt";
          #     chars = "\\x1bb";
          #   }
          #   {
          #     key = "D";
          #     mods = "Alt";
          #     chars = "\\x1bd";
          #   }
          #   {
          #     key = "Slash";
          #     mods = "Control";
          #     chars = "\\x1f";
          #   }
          #   {
          #     key = "Period";
          #     mods = "Alt";
          #     chars = "\\e-\\e.";
          #   }
          #   {
          #     key = "N";
          #     mods = "Command";
          #     command = {
          #       program = "open";
          #       args = [ "-nb" "io.alacritty" ];
          #     };
          #   }
          # ];
        };
      };

      programs.bat = {
        enable = true;
        config = { };
        themes = { };
      };

      programs.browserpass.enable = true;
      programs.browserpass.browsers = [ "firefox" ];

      programs.dircolors = {
        enable = true;
        enableZshIntegration = true;
        settings = { };
      };

      programs.direnv = {
        enable = true;
        config = { };
      };

      programs.emacs.enable = true;
      programs.emacs.package = pkgs.Emacs; # custom overlay

      programs.firefox.enable = true;
      programs.firefox.package = pkgs.Firefox; # custom overlay

      programs.firefox.extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        facebook-container
        ghostery
        honey
        privacy-badger
        browserpass
        browserpass-otp
        vimium
      ];

      programs.firefox.profiles = let
        defaultSettings = {
          "app.update.auto" = false;
          "browser.startup.homepage" = "about:blank";
          "browser.search.region" = "US";
          "browser.search.countryCode" = "US";
          "browser.search.isUS" = true;
          "browser.ctrlTab.recentlyUsedOrder" = false;
          "browser.newtabpage.enabled" = false;
          "browser.bookmarks.showMobileBookmarks" = true;
          "browser.uidensity" = 1;
          "browser.urlbar.placeholderName" = "DuckDuckGo";
          "browser.urlbar.update1" = true;
          "distribution.searchplugins.defaultLocale" = "en-US";
          "general.useragent.locale" = "en-US";
          "identity.fxaccounts.account.device.name" =
            config.networking.hostName;
          "privacy.trackingprotection.enabled" = true;
          "privacy.trackingprotection.socialtracking.enabled" = true;
          "privacy.trackingprotection.socialtracking.annotate.enabled" = true;
          "reader.color_scheme" = "sepia";
          "services.sync.declinedEngines" = "addons,passwords,prefs";
          "services.sync.engine.addons" = false;
          "services.sync.engineStatusChanged.addons" = true;
          "services.sync.engine.passwords" = false;
          "services.sync.engine.prefs" = false;
          "services.sync.engineStatusChanged.prefs" = true;
          "signon.rememberSignons" = false;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
      in {
        home = {
          id = 0;
          settings = defaultSettings;
          userChrome = (builtins.readFile (pkgs.substituteAll {
            name = "homeUserChrome";
            src = ../config/userChrome.css;
            tabLineColour = "#2aa198";
          }));
        };
        kroger = {
          id = 1;
          settings = defaultSettings;
          userChrome = (builtins.readFile (pkgs.substituteAll {
            name = "workUserChrome";
            src = ../config/userChrome.css;
            tabLineColour = "#cb4b16";
          }));
        };
      };

      programs.fzf.enable = true;
      programs.fzf.enableZshIntegration = true;

      programs.git = {
        enable = true;
        package = pkgs.gitAndTools.gitFull;
        userName = cfg.userName;
        userEmail = cfg.userEmail;

        aliases = {
          l = "log --pretty=oneline -n 20 --graph --abbrev-commit";
          s = "status -sb";
          tags = "tag -l";
          branches = "branch -a";
          remotes = "remote -v";
          amend = "commit --amend --reuse-message=HEAD";
        };

        ignores = [ ".envrc" ".DS_Store" ];

        extraConfig = {
          apply.whitespace = "fix";
          color.ui = "auto";
          credential.helper = "osxkeychain";
          github.user = "janders223";
          http.proxy = "http://127.0.0.1:3128";
          https.proxy = "http://127.0.0.1:3128";
          merge.log = true;
          "gitlab.gitlab.kroger.com/api/v4".user = "kon8522";
          core = {
            whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
            editor = "emacs";
            quotepath = "false";
            trustctime = false;
          };

          rerere = {
            enabled = true;
            autoupdate = true;
          };
        };

      };

      programs.man.enable = true;

      programs.password-store = {
        enable = true;
        package =
          pkgs.pass.withExtensions (ext: with ext; [ pass-otp pass-genphrase ]);
        settings = { PASSWORD_STORE_DIR = "${homeDir}/.password-store"; };
      };

      programs.zsh = {
        enable = true;
        enableAutosuggestions = true;
        enableCompletion = true;
        defaultKeymap = "emacs";
        sessionVariables = { RPROMPT = ""; };

        shellAliases = { };

        oh-my-zsh = {
          enable = true;

          theme = "robbyrussell";

          plugins = [
            "direnv"
            "docker"
            "emacs"
            "fd"
            "fzf"
            "git"
            "man"
            "osx"
            "pass"
            "ripgrep"
            "sudo"
            "terraform"
          ];
        };
      };

      home.file.".ssh/config".text = ''
        Host *
            Port 22
            ProxyCommand `which nc` -x 127.0.0.1:3129 %h %p
      '';

    };
  };
}
