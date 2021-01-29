nnoremap <silent> gh :LspSagaFinder<CR>
nnoremap <silent><leader>ca :LspSagaCodeAction<CR>
vnoremap <silent><leader>ca :'<,'>LspSagaRangeCodeAction<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>
nnoremap <silent>gr :LspSagaRename<CR>
nnoremap <silent> gd :LspSagaDefPreview<CR>
nnoremap <silent> [e :LspSagaDiagJumpPrev<CR>
nnoremap <silent> ]e :LspSagaDiagJumpNext<CR>
