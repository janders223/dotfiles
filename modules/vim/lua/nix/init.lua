require('nvim_utils')

local autocmds = {
	nix = {
		{"FileType", "nix", "setl noet ts=2 sw=2 sts=2"};
	};
}

nvim_create_augroups(autocmds)
