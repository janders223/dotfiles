{ pkgs }:
let
  vim-bettergrep = pkgs.vimUtils.buildVimPlugin {
    name = "vim-bettergrep";
    src = pkgs.fetchFromGitHub {
      owner = "qalshidi";
      repo = "vim-bettergrep";
      rev = "6db797d2a03efeee8fb4414c93a9016f6ccd38b8";
      sha256 = "01fa955mgn9p59sycp46g7vnw1h9v0xbszrz86j6hix51x7kzvzx";
    };
  };

  vim-lua = pkgs.vimUtils.buildVimPlugin {
    name = "vim-lua";
    src = pkgs.fetchFromGitHub {
      owner = "xolox";
      repo = "vim-lua-ftplugin";
      rev = "bcbf914046684f19955f24664c1659b330fcb241";
      sha256 = "18i1205hf2zz1ldjbdisaqknqqghh5wz59baplmxqnsm1wbrcb6n";
    };
  };

  vim-lsp-settings = pkgs.vimUtils.buildVimPlugin {
    name = "vim-lsp-settings";
    src = pkgs.fetchFromGitHub {
      owner = "janders223";
      repo = "vim-lsp-settings";
      rev = "b644e2405c2d9d3d6f8384aedb8def5208641a73";
      sha256 = "1llfxx0mhgfn14vk0s0bjf6rv644kgkaxiw4zdbwbzmwjp9brphg";
    };
  };

  vim-hcl = pkgs.vimUtils.buildVimPlugin {
    name = "vim-hcl";
    src = pkgs.fetchFromGitHub {
      owner = "jvirtanen";
      repo = "vim-hcl";
      rev = "94fbd199c8a947ede62f98509f91d637d7967454";
      sha256 = "0n2dmgfajji8nxxirb9q9jmqnzc1mjqnic5igs84pxmbc6r57zqq";
    };
  };

  vim-rest-console = pkgs.vimUtils.buildVimPlugin {
    name = "vim-rest-console";
    src = pkgs.fetchFromGitHub
      {
        owner = "diepm";
        repo = "vim-rest-console";
        rev = "7b407f47185468d1b57a8bd71cdd66c9a99359b2";
        sha256 = "1x7qicd721vcb7zgaqzy5kgiqkyj69z1lkl441rc29n6mwncpkjj";
      };
  };

in
with pkgs.vimPlugins; [
  nvim-treesitter # neovim 0.5
  nvim-lspconfig # neovim 0.5
  completion-nvim # neovim 0.5
  completion-treesitter # neovim 0.5
  lsp-status-nvim # neovim 0.5
  lsp_extensions-nvim # neovim 0.5
  # ale
  ctrlp-vim
  delimitMate
  dhall-vim
  indentLine
  nord-vim
  rust-vim
  tabular
  vim-airline
  vim-airline-themes
  vim-better-whitespace
  vim-bettergrep
  vim-commentary
  vim-dadbod
  vim-dirvish
  vim-dirvish-git
  vim-endwise
  vim-eunuch
  vim-fugitive
  vim-hcl
  vim-json
  # vim-lsp
  # vim-lsp-settings
  vim-lua
  vim-markdown
  vim-misc
  # vim-mucomplete
  vim-nix
  vim-repeat
  vim-rest-console
  vim-rhubarb
  vim-speeddating
  vim-surround
  vim-terraform
  vim-tmux-navigator
  vim-toml
  vim-unimpaired
  vim-yaml
]
