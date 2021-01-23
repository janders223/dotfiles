{}:
{
  config = ''
        set nocompatible              " be iMproved, required
    filetype off                  " required

    filetype plugin indent on

    "
    " Settings
    "
    set noerrorbells                " No beeps
    set number                      " Show line numbers
    set backspace=indent,eol,start  " Makes backspace key more powerful.
    set showcmd                     " Show me what I'm typing

    set noswapfile                  " Don't use swapfile
    set nobackup                    " Don't create annoying backup files
    set nowritebackup
    set splitright                  " Split vertical windows right to the current windows
    set splitbelow                  " Split horizontal windows below to the current windows
    set encoding=utf-8              " Set default encoding to UTF-8
    set autowrite                   " Automatically save before :next, :make etc.
    set autoread                    " Automatically reread changed files without asking me anything
    set laststatus=2
    set hidden


    set ruler                       " Show the cursor position all the time
    au FocusLost * :wa              " Set vim to save the file on focus out.

    set fileformats=unix,dos,mac    " Prefer Unix over Windows over OS 9 formats

    set noshowmode                  " We show the mode with airline or lightline
    set incsearch                   " Shows the match while typing
    set hlsearch                    " Highlight found searches
    set ignorecase                  " Search case insensitive...
    set smartcase                   " ... but not when search pattern contains upper case characters
    set ttyfast
    set lazyredraw                 " Wait to redraw "

    set shortmess+=c   " Shut off completion messages
    set belloff+=ctrlg " If Vim beeps during completion

    " speed up syntax highlighting
    set nocursorcolumn
    set nocursorline

    syntax sync minlines=256
    set synmaxcol=300
    set re=1

    " open help vertically
    command! -nargs=* -complete=help Help vertical belowright help <args>
    autocmd FileType help wincmd L

    " Make Vim to handle long lines nicely.
    set wrap
    set textwidth=80
    set formatoptions=qrn1

    " Do not use relative numbers to where the cursor is.
    set norelativenumber

    " Apply the indentation of the current line to the next line.
    set autoindent
    set smartindent
    set complete-=i
    set showmatch
    set smarttab

    set tabstop=4
    set shiftwidth=4
    set expandtab

    set nrformats-=octal
    set shiftround

    " Time out on key codes but not mappings.
    " Basically this makes terminal Vim work sanely.
    set notimeout
    set ttimeout
    set ttimeoutlen=10

    " Better Completion
    set complete=.,w,b,u,t
    set completeopt-=preview
    set completeopt=longest,menuone,noinsert

    if &history < 1000
    set history=50
    endif

    if &tabpagemax < 50
    set tabpagemax=50
    endif

    if !empty(&viminfo)
    set viminfo^=!
    endif

    if !&scrolloff
    set scrolloff=1
    endif
    if !&sidescrolloff
    set sidescrolloff=5
    endif
    set display+=lastline

    " In many terminal emulators the mouse works just fine, thus enable it.
    if has('mouse')
    set mouse=a
    endif

    " If linux then set ttymouse
    let s:uname = system("echo -n \"$(uname)\"")
    if !v:shell_error && s:uname == "Linux" && !has('nvim')
    set ttymouse=xterm
    endif

    " Convenient command to see the difference between the current buffer and the
    " file it was loaded from, thus the changes you made.
    " Only define it when not defined already.
    if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
    \ | wincmd p | diffthis
    endif

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \  exe "normal! g`\"" |
    \ endif

    syntax enable
    if has('gui_running')
    set transparency=3
    " fix js regex syntax
    set regexpengine=1
    syntax enable
    endif
    set background=dark
    colorscheme nord
    set guifont=Hasklig:h18
    set guioptions-=L

    " This comes first, because we have mappings that depend on leader
    " " With a map leader it's possible to do extra key combinations
    " " i.e: <leader>w saves the current file
    let mapleader = ","
    let g:mapleader = ",""

    " Better split switching
    map <C-j> <C-W>j
    map <C-k> <C-W>k
    map <C-h> <C-W>h
    map <C-l> <C-W>l

    " Just go out in insert mode
    imap jk <ESC>l

    " Search mappings: These will make it so that going to the next one in a
    " search will center on the line it's found in.
    nnoremap n nzzzv
    nnoremap N Nzzzv

    " Act like D and C
    nnoremap Y y$

    " Do not show stupid q: window
    map q: :q

    " Sometimes this happens and I hate it
    map :Vs :vs
    map :Sp :sp

    " ----------------------------------------- "
    " File Type settings               "
    " ----------------------------------------- "

    augroup filetype_nix
    autocmd!
    autocmd FileType nix :packadd vim-nix
    augroup END

    augroup filetypedetect
    au BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
    au BufNewFile,BufRead .nginx.conf*,nginx.conf* setf nginx
    augroup END

    au BufNewFile,BufRead *.vim setlocal noet ts=4 sw=4 sts=4
    au BufNewFile,BufRead *.txt setlocal noet ts=4 sw=4
    au BufNewFile,BufRead *.md setlocal spell noet ts=4 sw=4
    au BufNewFile,BufRead *.yml,*.yaml setlocal expandtab ts=2 sw=2
    au BufNewFile,BufRead *.json setlocal expandtab ts=2 sw=2
    au FileType terraform setlocal noet ts=2 sw=2 sts=2
    au FileType nginx setlocal noet ts=4 sw=4 sts=4

    let g:airline_theme='minimalist'

    " Wildmenu completion {{{
      set wildmenu
      " set wildmode=list:longest
      set wildmode=list:full

      set wildignore+=.hg,.git,.svn                    " Version control
      set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
      set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
      set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
      set wildignore+=*.spl                            " compiled spelling word lists
      set wildignore+=*.sw?                            " Vim swap files
      set wildignore+=*.DS_Store                       " OSX bullshit
      set wildignore+=*.luac                           " Lua byte code
      set wildignore+=migrations                       " Django migrations
      set wildignore+=go/pkg                           " Go static files
      set wildignore+=go/bin                           " Go bin files
      set wildignore+=go/bin-vagrant                   " Go bin-vagrant files
      set wildignore+=*.pyc                            " Python byte code
      set wildignore+=*.orig                           " Merge resolution files

      let g:better_whitespace_enabled = 1
      let g:strip_whitespace_on_save  = 1

      nnoremap <C-n> :Dirvish<CR>

      " ==================== Fugitive ====================
        nnoremap <leader>ga :Git add %:p<CR><CR>
        nnoremap <leader>gs :Gstatus<CR>
        nnoremap <leader>gp :Gpush<CR>
        vnoremap <leader>gb :Gblame<CR>

        let g:indentLine_concealcursor = 'inc'
        " do not hide markdown
        set conceallevel=0

        let g:vim_json_syntax_conceal=0

        let g:terraform_align=1
        let g:terraform_fold_sections=1
        let g:terraform_fmt_on_save=1

        lua << EOF
    local nvim_lsp = require('lspconfig')
    local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    end

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
    require('lspconfig').util.nvim_multiline_command [[
      :hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      :hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      :hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd!
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
    end
    end

    -- Use a loop to conveniently both setup defined servers
    -- and map buffer local keybindings when the language server attaches
    local servers = { "rnix", "terraformls" }
    for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup { on_attach = on_attach }
    end
    EOF
  '';
}
