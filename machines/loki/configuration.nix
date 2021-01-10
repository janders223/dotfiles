{ pkgs ? import <nixpkgs> { }, ... }:
let
  vimrc = import ../../vim/vimrc.nix { };
  vimPackages = import ../../vim/vim.nix { inherit pkgs; };
  dir_colors = import ../../dir_colors/dir_colors.nix { };

in
{
  home.packages = with pkgs; [
    vim
    direnv
    starship
  ];

  manual.manpages.enable = true;

  programs.bash = {
    enable = true;
    historyControl = [
      "erasedups"
      "ignoredups"
      "ignorespace"
    ];
    shellAliases = {
      l = "ls -halF";
      vim = "nvim";
    };
    profileExtra = ''
      . /home/janders223/.nix-profile/etc/profile.d/nix.sh

      eval "$(starship init bash)"

      ls() {
      ${pkgs.coreutils}/bin/ls --color=auto "$@"
      }
    '';
  };

  programs.zsh = {
    enable = true;
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
    settings = { };
  };

  programs.man = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraConfig = vimrc.config;
    plugins = vimPackages;
  };

  # programs.startship = {
  #   enable = true;
  #   enableBashIntegration = true;
  #   enableZshIntegration = true;
  # };

  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/shell";
  };
}
