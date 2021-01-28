{ pkgs }:
let
  vim-galaxyline = pkgs.vimUtils.buildVimPlugin {
    name = "vim-galaxyline";
    src = pkgs.fetchFromGitHub {
      owner = "glepnir";
      repo = "galaxyline.nvim";
      rev = "22791e9aadfc2a24ccc22d21b4c50f6b52e12980";
      sha256 = "1dw9k5ql7h8mgj7ag34pxa2jr9b2k788csc2a0jmyp6qp0d0x5ad";
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

  nvim-web-devicons = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-web-devicons";
    src = pkgs.fetchFromGitHub {
      owner = "kyazdani42";
      repo = "nvim-web-devicons";
      rev = "aaffb87b5a640d15a566d9af9e74baafcf9ec016";
      sha256 = "1qk2h8cwcb0v12lxayjdxka6wh5r1phn9cz5xkm5hvm1vcwrvlln";
    };
  };

  nvim-utils = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-utils";
    src = pkgs.fetchFromGitHub {
      owner = "norcalli";
      repo = "nvim_utils";
      rev = "71919c2f05920ed2f9718b4c2e30f8dd5f167194";
      sha256 = "0wn1lzbpa69aplxqyp4mrf6gaa937mfjm8p3hcglhmsfw8v2ifln";
    };
  };

  treesitter-playground = pkgs.vimUtils.buildVimPlugin {
    name = "treesitter-playground";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-treesitter";
      repo = "playground";
      rev = "7e373e5706a2df71fd3a96b50d1f7b0c3e7a0b36";
      sha256 = "1vrfjv22whdmwna4xlvpsajx69fs8dkfwk0ji1jnvbyxmhki8mik";
    };
  };

  fzf-checkout = pkgs.vimUtils.buildVimPlugin {
    name = "fzf-checkout";
    src = pkgs.fetchFromGitHub {
      owner = "stsewd";
      repo = "fzf-checkout.vim";
      rev = "bc85ea55103e3c9a58c8cd2c9a501aaf155384af";
      sha256 = "119qnc673v972cmfaiw0afd6wb85zg3l5sq2p9i9lfyy00kqg32h";
    };
		buildPhase = ":";
  };
in
with pkgs.vimPlugins; [
  nvim-treesitter # neovim 0.5
  nvim-lspconfig # neovim 0.5
  completion-nvim # neovim 0.5
  completion-treesitter # neovim 0.5
  lsp-status-nvim # neovim 0.5
  lsp_extensions-nvim # neovim 0.5
  delimitMate
  dhall-vim
	fzf-checkout
  fzf-vim
  gv-vim
  indentLine
  nord-vim
  nvim-treesitter
  nvim-utils
  nvim-web-devicons
  rust-vim
  tabular
  vim-better-whitespace
  vim-galaxyline
  vim-commentary
  vim-dadbod
  vim-dirvish
  vim-dirvish-git
  vim-endwise
  vim-eunuch
  vim-fugitive
  vim-hcl
  vim-json
  vim-lua
  vim-markdown
  vim-misc
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
