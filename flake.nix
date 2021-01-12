{
  description = "janders223 nixes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-20.09-darwin";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, darwin, nixpkgs, ... }@inputs: {
    darwinConfigurations."OF060VV4A8HTD6F" = darwin.lib.darwinSystem {
      modules = [ ./machines/work/configuration.nix ];
    };

    nixosConfigurations.loki = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./machines/loki/configuration.nix ];
    };

    # homeManagerConfigurations = {
    #   loki = inputs.home-manager.lib.homeManagerConfiguration {
    #     configuration = import ./machines/loki/configuration.nix;
    #     system = "x86_64-linux";
    #     homeDirectory = "/home/janders223";
    #     username = "janders223";
    #   };
    # };
  };
}
