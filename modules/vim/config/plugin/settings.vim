" open help vertically
command! -nargs=* -complete=help Help vertical belowright help <args>
autocmd FileType help wincmd L

set cmdheight=2
set colorcolumn=80
set completeopt=menuone,noinsert,noselect
set expandtab
set foldexpr=nvim_treesitter#foldexpr()
set foldmethod=expr
set hidden
set incsearch
set nobackup
set noerrorbells
set nohlsearch
set noshowmode
set noswapfile
set nowrap
set number
set relativenumber
set scrolloff=8
set shiftwidth=4
set shortmess+=c
set signcolumn=yes
set smartindent
set softtabstop=4
set splitbelow
set splitright
set tabstop=4
set termguicolors
set undodir=~/.vim/undodir
set undofile
set updatetime=50
set wildignore=".hg,.git,.svn,*.aux,*.out,*.toc,*.jpg,*.bmp,*.gif,*.png,*.jpeg,*.o,*.obj,*.exe,*.dll,*.manifest,*.spl,*.sw?,*.DS_Store,*.luac,go/pkg,go/bin,go/bin-vagrant,*.org"
