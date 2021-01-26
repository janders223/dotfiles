require('nvim_utils')

local autocmds = {
	vim = {
		{"FileType", "vim", "setl noet ts=4 sw=4 sts=4"};
	};
}

nvim_create_augroups(autocmds)

