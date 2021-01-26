require('nvim_utils')

local autocmds = {
	nginx = {
        {"BufNewFile,BufRead", ".nginx.conf", "setf nginx"},
		{"FileType",     "nginx",   "setl noet ts=4 sw=4 sts=4"};
	};
}

nvim_create_augroups(autocmds)
