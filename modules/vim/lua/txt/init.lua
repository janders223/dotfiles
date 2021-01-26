require('nvim_utils')

local autocmds = {
	txt = {
		{"FileType", "txt",   "setl noet ts=4 sw=4"};
	};
}

nvim_create_augroups(autocmds)

