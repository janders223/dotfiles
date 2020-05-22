{ config, pkgs, lib, ... }:

let home_directory = builtins.getEnv "HOME";

in {
  home-manager.users.kon8522 = rec {
    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    home.sessionVariables = {
      GNUPGHOME = "${xdg.configHome}/gnupg";
      CURL_HOME = "${xdg.configHome}/curl";
      MANPAGER = "less -X";
      ftp_proxy = "http://127.0.0.1:3128";
      http_proxy = "http://127.0.0.1:3128";
      https_proxy = "http://127.0.0.1:3128";
      FTP_PROXY = "http://127.0.0.1:3128";
      HTTP_PROXY = "http://127.0.0.1:3128";
      HTTPS_PROXY = "http://127.0.0.1:3128";
    };

    home.file.".wgetrc".text = ''
      use_proxy=yes
      http_proxy=http://127.0.0.1:3128
      https_proxy=http://127.0.0.1:3128
    '';

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

      profileExtra = ''
        export GPG_TTY=$(tty)
        ${pkgs.gnupg}/bin/gpg-connect-agent updatestartuptty /bye > /dev/null
      '';

      initExtra = ''
        export SSH_AUTH_SOCK=$(${pkgs.gnupg}/bin/gpgconf --list-dirs agent-ssh-socket)
        export PATH=$PATH:${home_directory}/.emacs/bin
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
      # packages = {
      #   "github.com/motemen/gore/cmd/gore" = builtins.fetchGit "github.com/motemen/gore/cmd/gore";
      #     "github.com/stamblerre/gocode" = builtins.fetchGit "github.com/stamblerre/gocode";
      #     "golang.org/x/tools/cmd/godoc" = builtins.fetchGit "golang.org/x/tools/cmd/godoc";
      #     "golang.org/x/tools/cmd/goimports" =  builtins.fetchGit "golang.org/x/tools/cmd/goimports";
      #     "golang.org/x/tools/cmd/gorename" = builtins.fetchGit "golang.org/x/tools/cmd/gorename";
      #     "golang.org/x/tools/cmd/guru" = builtins.fetchGit "golang.org/x/tools/cmd/guru";
      #     "github.com/cweill/gotests" = builtins.fetchGit "github.com/cweill/gotests";
      #     "github.com/fatih/gomodifytags" = builtins.fetchGit "github.com/fatih/gomodifytags";
      # };
    };

    xdg = {
      enable = true;

      configHome = "${home_directory}/.config";
      dataHome = "${home_directory}/.local/share";
      cacheHome = "${home_directory}/.cache";

      configFile."curl/.curlrc".text = import ./config/curlrc.nix;

      configFile."gnupg/gpg-agent.conf".text =
        import ./config/gpg-agent.nix { inherit pkgs; };

      configFile."gnupg/gpg.conf".text = import ./config/gpg.nix;

      configFile."doom/config.el".text = builtins.readFile ./doom/config.el;
      configFile."doom/init.el".text = builtins.readFile ./doom/init.el;
      configFile."doom/packages.el".text = builtins.readFile ./doom/packages.el;
    };

    home.file.".mbsyncrc".text = import ./config/mbsync.nix { inherit pkgs; };

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "20.03";
  };
}
