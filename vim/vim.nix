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

in pkgs.vim_configurable.customize {
    name = "vim";

    vimrcConfig.packages.myVimPackage = with pkgs.vimPlugins; {
        start = [
            ctrlp-vim
                delimitMate
                indentLine
                nerdtree
                nord-vim
                tabular
                vim-airline
                vim-airline-themes
                vim-better-whitespace
                vim-bettergrep
                vim-commentary
                vim-endwise
                vim-fugitive
                vim-misc
                vim-qf
                vim-repeat
                vim-surround
                vim-tmux-navigator
        ];

        opt = [
            dhall-vim
                vim-json
                vim-lua
                vim-markdown
                vim-nix
                vim-terraform
                vim-toml
                vim-yaml
        ];
    };

    vimrcConfig.customRC = builtins.readFile ./vimrc;
}
