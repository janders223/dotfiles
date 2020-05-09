.PHONY: all
all: symlinks brew

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
