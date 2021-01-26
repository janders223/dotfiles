require('nvim_utils')

local autocmds = {
	yml = {
		{"FileType", "yml", "setl expandtab ts=2 sw=2"};
	};
}

nvim_create_augroups(autocmds)

