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

  lspsaga.nvim = pkgs.vimUtils.buildVimPlugin {
    name = "lspsaga.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "glepnir";
      repo = "lspsaga.nvim";
      rev = "7fdaaad337ec7f6ba684c8a0dec90053a7c87f51";
      sha256 = "116i9p0gc5q16nwc9m0c2mkhrjvymh0yjmzbrw8nvbc9dsqz4gny";
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

	nvim-ts-rainbow = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-ts-rainbow";
    src = pkgs.fetchFromGitHub {
      owner = "p00f";
      repo = "nvim-ts-rainbow";
      rev = "adad3ea7eb820b7e0cc926438605e7637ee1f5e6";
      sha256 = "0vbd0a3kblbx28s2p7ljsalb1hymr2qjhjqgr03sg1a6hmxib1i0";
    };
	};

	playground = pkgs.vimUtils.buildVimPlugin {
    name = "playground";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-treesitter";
      repo = "playground";
      rev = "7e373e5706a2df71fd3a96b50d1f7b0c3e7a0b36";
      sha256 = "1vrfjv22whdmwna4xlvpsajx69fs8dkfwk0ji1jnvbyxmhki8mik";
    };
	};

in
  with pkgs.vimPlugins; [
		completion-treesitter
		lspsaga.nvim
		nvim-treesitter
		playground
    completion-nvim
    delimitMate
    dracula-vim
    fzf-checkout
    fzf-vim
    indentLine
    nvim-lspconfig
    nvim-web-devicons
    tabular
    vim-commentary
    vim-dirvish
    vim-dirvish-git
    vim-endwise
    vim-fugitive
    vim-galaxyline
    vim-json
    vim-nix
    vim-repeat
    vim-surround
    vim-terraform
    vim-tmux-navigator
    vim-yaml
  ]
