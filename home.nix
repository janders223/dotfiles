{ config, pkgs, lib, ... }:

let

  home_directory = builtins.getEnv "HOME";
  name = "Jim Anders";
  gmail = "jimanders223@gmail.com";
  ingage = "jim.anders@ingagepartners.com";
  notmuchrc = "${home_directory}/.config/notmuch/notmuchrc";

in {
  home-manager.users.kon8522 = rec {
    programs.home-manager.enable = true;

    accounts.email = {
      certificatesFile = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
      maildirBasePath = "${home_directory}/.mail";
      accounts = {
        Gmail = {
          address = "${gmail}";
          userName = "${gmail}";
          flavor = "gmail.com";
          passwordCommand =
            "security find-generic-password -a ${gmail} -s imap.gmail.com -w";
          primary = true;
          mbsync = {
            enable = true;
            create = "both";
            expunge = "both";
            patterns = [ "*" "[Gmail]*" ];
          };
          realName = "${name}";
          msmtp.enable = true;
          notmuch.enable = true;
        };
        Inagage = {
          address = "${ingage}";
          userName = "${ingage}";
          flavor = "gmail.com";
          passwordCommand =
            "security find-generic-password -a ${ingage} -s imap.gmail.com -w";
          mbsync = {
            enable = true;
            create = "both";
            expunge = "both";
            patterns = [ "*" "[Gmail]*" ];
          };
          realName = "${name}";
          msmtp.enable = true;
          notmuch.enable = true;
        };
      };
    };

    home.sessionVariables = {
      NOTMUCH_CONFIG = "${notmuchrc}";
      MANPAGER = "less -X";
      ftp_proxy = "http://127.0.0.1:3128";
      http_proxy = "http://127.0.0.1:3128";
      https_proxy = "http://127.0.0.1:3128";
      FTP_PROXY = "http://127.0.0.1:3128";
      HTTP_PROXY = "http://127.0.0.1:3128";
      HTTPS_PROXY = "http://127.0.0.1:3128";
    };

    programs.bash = { enable = true; };

    programs.zsh = rec {
      enable = true;
      dotDir = ".config/zsh";
      autocd = true;
      enableCompletion = true;
      enableAutosuggestions = true;

      history = {
        size = 50000;
        save = 500000;
        path = "${dotDir}/history";
        ignoreDups = true;
        share = true;
      };

      initExtra = ''
        export PATH=$PATH:${home_directory}/.emacs.d/bin
        export PATH=$PATH:${pkgs.coreutils}/bin
        export PATH=$PATH:/Applications/VLC.app/Contents/MacOS
      '';

      shellAliases = { l = "ls -halF"; };
    };

    programs.git = {
      enable = true;

      userName = "Jim Anders";

      signing = {
        key = "0x61EFDD56848C9DF8";
        signByDefault = true;
      };

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

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.go = {
      enable = true;
      goPath = "${xdg.cacheHome}/go";
    };

    programs = {
      msmtp.enable = true;
      mbsync.enable = true;
      notmuch = {
        enable = true;
        hooks = {
          postNew =
            "${pkgs.afew}/bin/afew -C ${notmuchrc} --tag --new --verbose";
        };
        new = {
          ignore = [ "trash" "*.json" ];
          tags = [ "new" ];
        };
        search.excludeTags = [ "trash" "deleted" "spam" ];
        maildir.synchronizeFlags = true;
      };
    };

    programs.afew = {
      enable = true;
      extraConfig = ''
        [SpamFilter]
        [KillThreadsFilter]
        [ListMailsFilter]
        [SentMailsFilter]
        sent_tag = sent
        [ArchiveSentMailsFilter]
        [InboxFilter]
        [MailMover]
        folders = Gmail/Inbox
        rename = True
        max_age = 15
        Gmail/Inbox = 'tag:spam':Gmail/[Gmail]/Spam 'tag:trash':Gmail/[Gmail]/Trash \
                      'NOT tag:inbox':'Gmail/[Gmail]/All Mail'
      '';
    };

    xdg = {
      enable = true;

      configHome = "${home_directory}/.config";
      dataHome = "${home_directory}/.local/share";
      cacheHome = "${home_directory}/.cache";

      configFile."doom/config.el".text = builtins.readFile ./doom/config.el;
      configFile."doom/init.el".text = builtins.readFile ./doom/init.el;
      configFile."doom/packages.el".text = builtins.readFile ./doom/packages.el;
    };

    home.file.".hammerspoon/init.lua".text =
      builtins.readFile ./config/init.lua;

    home.stateVersion = "20.03";
  };
}
