{ pkgs, inputs }:
let
  neovim-nightly = inputs.neovim-nightly;
in {
    enable = true;
    package = neovim-nightly.defaultPackage."${pkgs.system}";
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraConfig = builtins.readFile ./vimrc;
    plugins = import ./plugins.nix { inherit pkgs; };
  }
