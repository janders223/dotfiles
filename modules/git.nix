{pkgs}:
{
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    aliases = {
      l = "log --pretty=oneline -n 20 --graph --abbrev-commit";
      s = "status -sb";
      p = "!'git pull; git submodule foreach git pull origin master'";
      go = "!f() { git checkout -b \"$1\" 2> /dev/null || git checkout \"$1\"; }; f";
      tags = "tag - l";
      branches = "branch - a";
      remotes = "remote -v";
      amend = "commit --amend --reuse-message=HEAD";
      credit = "!f() { git commit --amend --author \"$1 <$2>\" -C HEAD; }; f";
      reb = "!r() { git rebase -i HEAD~$1; }; r";
      contributors = "shortlog --summary --numbered";
      lg = "log --color --decorate --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an (%G?)>%Creset' --abbrev-commit";
      undo = "!git reset HEAD~1 --mixed";
    };

    signing = {
      key = "0x14642134887B748A";
      signByDefault = true;
    };

    ignores = [
      "result"
      ".envrc"
      ".direnv"
      ".terraform"
      ".DS_Store"
      ".direnv/*"
			".lua"
			"~/"
    ];

    userEmail = "jimanders223@gmail.com";
    userName = "Jim Anders";
  }
