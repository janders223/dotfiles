require('nvim_utils')

local autocmds = {
	tmux = {
		{"BufNewFile,BufRead", ".tmux.conf*", "setf tmux"};
	};
}

nvim_create_augroups(autocmds)
