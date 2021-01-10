loki:
	git add .
	nix build  --impure .#homeManagerConfigurations.loki.activationPackage
	./result/activate
