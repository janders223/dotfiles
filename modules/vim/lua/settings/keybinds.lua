vim.g.mapleader = " "

vim.api.nvim_set_keymap('i' , 'jk'    , '<ESC>'  , { noremap = false , silent = false })
vim.api.nvim_set_keymap(''  , ':Vs'   , ':vs'    , { noremap = false , silent = false })
vim.api.nvim_set_keymap(''  , ':Sp'   , ':sp'    , { noremap = false , silent = false })
vim.api.nvim_set_keymap(''  , 'q:'    , ':q'     , { noremap = false , silent = false })
vim.api.nvim_set_keymap('n' , 'Y'     , 'y$'     , { noremap = false , silent = false })
vim.api.nvim_set_keymap('n' , 'n'     , 'nzzzv'  , { noremap = true  , silent = false })
vim.api.nvim_set_keymap('n' , 'N'     , 'Nzzzv'  , { noremap = true  , silent = false })
vim.api.nvim_set_keymap(''  , '<C-j>' , '<C-W>j' , { noremap = false , silent = false })
vim.api.nvim_set_keymap(''  , '<C-k>' , '<C-W>k' , { noremap = false , silent = false })
vim.api.nvim_set_keymap(''  , '<C-h>' , '<C-W>h' , { noremap = false , silent = false })
vim.api.nvim_set_keymap(''  , '<C-l>' , '<C-W>l' , { noremap = false , silent = false })
