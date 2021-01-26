vim.api.nvim_set_keymap('', '<leader>ga', ':Git add  %:p<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', '<leader>gs', ':Gstatus<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', '<leader>gp', ':Gpush<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', '<leader>gb', ':Gblame<CR>', { noremap = true, silent = true })
