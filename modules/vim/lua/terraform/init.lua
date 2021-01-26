require('nvim_utils')

vim.g.terraform_align = true
vim.g.terraform_fold_sections = true
vim.g.terraform_fmt_on_save = true

local autocmds = {
	terraform = {
		{"FileType",     "terraform",   "setl noet ts=2 sw=2 sts=2"};
	};
}

nvim_create_augroups(autocmds)
