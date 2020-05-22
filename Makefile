.PHONY: all
all: darwin doom

.PHONY: darwin
darwin:
	@darwin-rebuild switch

.PHONY: setup
setup:
	@./macos

.PHONY: doom
doom:
	@doom sync -e
	@doom env -a "^SSH_"
