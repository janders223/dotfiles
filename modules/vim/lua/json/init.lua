require('nvim_utils')

vim.api.nvim_set_var('vim_json_syntax_conceal', false)

local autocmds = {
    json = {
        {"FileType", "json", "setl expandtab ts=2 sw=2"}
    }
}
