{ config, pkgs, inputs, ... }:
let
  # vimrc = import ../vim/vimrc.nix { };
  vimPackages = import ../vim/vim.nix { inherit pkgs; };
  dir_colors = import ../dir_colors/dir_colors.nix { };
  packages = import ./packages.nix { inherit pkgs; };
  bin = import ../bin { inherit pkgs; };
in
{
  home.packages = packages ++ bin;

  manual.manpages.enable = true;

  programs.bash = {
    enable = true;
    historyControl = [
      "erasedups"
      "ignoredups"
      "ignorespace"
    ];
    shellAliases = {
      l = "${pkgs.coreutils}/bin/ls -halF";
      vim = "nvim";
    };
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    autocd = true;
    defaultKeymap = "emacs";
    dotDir = ".config/zsh";
    history.path = ".config/zsh/zsh_history";
    shellAliases = {
      l = "${pkgs.coreutils}/bin/ls -halF";
      vim = "nvim";
    };
    initExtraFirst = ''
      source ~/.nix-profile/etc/profile.d/nix.sh

      autoload -U edit-command-line
      zle -N edit-command-line
      bindkey -M vicmd v edit-command-line
    '';
  };

  programs.dircolors = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    extraConfig = dir_colors;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableNixDirenvIntegration = true;
    #config = {};
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
    aliases = {
      l = "log --pretty=oneline -n 20 --graph --abbrev-commit";
      s = "status -sb";
      d = "!'git diff-index --quiet HEAD -- || clear; git --no-pager diff --patch-with-stat'";
      di = "!'d() { git diff --patch-with-stat HEAD~$1; }; git diff-index --quiet HEAD -- || clear; d'";
      p = "!'git pull; git submodule foreach git pull origin master'";
      pr = "!'pr () { git fetch origin pull/$1/head:pr-$1; git checkout pr-$1; }; pr'";
      c = "clone --recursive";
      ca = "!git add - A && git commit - av";
      go = "!f() { git checkout -b \"$1\" 2> /dev/null || git checkout \"$1\"; }; f";
      graph = "log --graph --color --pretty=format:'%C(yellow)%H%C(green)%d%C(reset)%n%x20%cd%n%x20%cn%x20(%ce)%n%x20%s%n'";
      tags = "tag - l";
      branches = "branch - a";
      remotes = "remote -v";
      amend = "commit --amend --reuse-message=HEAD";
      credit = "!f() { git commit --amend --author \"$1 <$2>\" -C HEAD; }; f";
      reb = "!r() { git rebase -i HEAD~$1; }; r";
      fb = "!f() { git branch -a --contains $1; }; f";
      ft = "!f() { git describe --always --contains $1; }; f";
      fc = "!f() { git log --pretty=format:'%C(yellow)%h  %Cblue%ad  %Creset%s%Cgreen  [%cn] %Cred%d' --decorate --date=short -S$1; }; f";
      fm = "!f() { git log --pretty=format:'%C(yellow)%h  %Cblue%ad  %Creset%s%Cgreen  [%cn] %Cred%d' --decorate --date=short --grep=$1; }; f";
      dm = "!git branch --merged | grep -v '\\*' | xargs -n 1 git branch -d; git remote -v update -p";
      contributors = "shortlog --summary --numbered";
      lg = "log - -color - -decorate - -graph - -pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an (%G?)>%Creset' --abbrev-commit";
      mdiff = "!f() { git stash | head -1 | grep -q 'No local changes to save'; x=$?; git merge --no-commit $1 &>/dev/null; git add -u &>/dev/null; git diff --staged; git reset --hard &>/dev/null; test $x -ne 0 && git stash pop &>/dev/null; }; f";
      unreleased = "!f() { git fetch --tags && git diff $(git tag | tail -n 1); }; f";
      up = "!git pull origin master && git remote prune origin && git submodule update - -init - -recursive";
      undo = "!git reset HEAD~1 --mixed";
      top = "!git log - -format=format:%an | sort | uniq -c | sort -r | head -n 20";
    };

    signing = {
      key = "0x14642134887B748A";
      signByDefault = true;
    };

    userEmail = "jimanders223@gmail.com";
    userName = "Jim Anders";
  };

  programs.gpg = {
    enable = true;
    settings = {
      personal-cipher-preferences = "AES256 AES192 AES";
      personal-digest-preferences = "SHA512 SHA384 SHA256";
      personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";
      default-preference-list = "SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed";
      cert-digest-algo = "SHA512";
      s2k-digest-algo = "SHA512";
      s2k-cipher-algo = "AES256";
      charset = "utf-8";
      fixed-list-mode = true;
      no-comments = true;
      no-emit-version = true;
      no-greeting = true;
      keyid-format = "0xlong";
      list-options = "show-uid-validity";
      verify-options = "show-uid-validity";
      with-fingerprint = true;
      require-cross-certification = true;
      no-symkey-cache = true;
      use-agent = true;
      throw-keyids = true;
    };
  };

  programs.man = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly.defaultPackage."${pkgs.system}";
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraConfig = builtins.readFile ../vim/vimrc;
    plugins = vimPackages;
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    sensibleOnTop = false;
    terminal = "screen-256color";
    shortcut = "s";
    secureSocket = true;
    newSession = true;
    clock24 = true;
    escapeTime = 50;
    baseIndex = 1;
    extraConfig = builtins.readFile ../config/tmux.conf;
    plugins = with pkgs; [
      tmuxPlugins.nord
      tmuxPlugins.vim-tmux-navigator
    ];
  };
}
