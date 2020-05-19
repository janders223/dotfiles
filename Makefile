.PHONY: all
all: brew symlinks setup

.PHONY: symlinks
symlinks: $(patsubst %.symlink,~/.%,$(wildcard *.symlink))

~/.%: %.symlink
	ln -sf $(realpath $<) $@

.PHONY: brew
brew:
	@brew bundle

.PHONY: brewfile
brewfile:
	@brew bundle dump --force

.PHONY: setup
setup:
	@./macos

.PHONY: doom
doom:
	@doom sync
	@doom env -a "^SSH_"
