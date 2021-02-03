local nvim_lsp = require('lspconfig')
local saga = require 'lspsaga'

saga.init_lsp_saga()

local servers = { "rnix", "rust_analyzer", "terraformls", "tsserver", "vimls" }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup { on_attach=require'completion'.on_attach }
end
