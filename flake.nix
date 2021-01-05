{
  description = "janders223 nixes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, darwin, nixpkgs }: {
    darwinConfigurations."OF060VV4A8HTD6F" = darwin.lib.darwinSystem {
      modules = [ ./machines/work/configuration.nix ];
    };
  };
}
