local nvim_lsp = require('lspconfig')

-- Shamelessly ripped off from
-- https://github.com/glepnir/nvim/blob/db2f872bbcd3ee995bad86f7b2735aef759f9a02/lua/internal/lspconfig.lua#L9-L21
local enhance_attach = function(client,bufnr)
  local has_completion,completion = pcall(require,'completion')
  if not has_completion then
    print('Does not load completion-nvim')
    return
  end
  completion.on_attach()

  -- if client.resolved_capabilities.document_formatting then
  --   action.lsp_before_save()
  -- end
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

vim.api.nvim_set_keymap('n' , '<leader>vd'  , ':lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n' , '<leader>vi'  , ':lua vim.lsp.buf.implementation()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n' , '<leader>vsh' , ':lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n' , '<leader>vrr' , ':lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n' , '<leader>vrn' , ':lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n' , '<leader>vh'  , ':lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n' , '<leader>vca' , ':lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n' , '<leader>vsd' , ':lua vim.lsp.util.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>', { noremap = true, silent = true })

local servers = { "rnix", "terraformls" }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup { on_attach=enhance_attach }
end

