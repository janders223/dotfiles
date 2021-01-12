{
  description = "janders223 nixes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-20.09-darwin";
    nixos.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixos";
  };

  outputs = { self, darwin, nixpkgs, ... }@inputs: {
    darwinConfigurations."OF060VV4A8HTD6F" = darwin.lib.darwinSystem {
      modules = [ ./machines/work/configuration.nix ];
    };

    nixosConfigurations.loki = inputs.nixos.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./machines/loki/configuration.nix
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.janders223 = import ./machines/loki/home.nix;
        }
      ];
    };
  };
}
