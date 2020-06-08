.PHONY: all
all: darwin doom

.PHONY: darwin
darwin:
	@darwin-rebuild switch

.PHONY: doom
doom:
	@doom sync -e
	@doom env -a "^SSH_"
