require('nvim_utils')

local autocmds = {
	markdown = {
		{"FileType",     "markdown",   "setl spell noet ts=4 sw=4"};
	};
}

nvim_create_augroups(autocmds)
