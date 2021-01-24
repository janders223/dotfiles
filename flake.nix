{
  description = "janders223 nixes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs:
    let
      nixpkgs = inputs.nixpkgs;
      neovim-nightly = inputs.neovim-nightly;
      darwinDefaults = { config, pkgs, lib, ... }: {
        imports = [ inputs.home-manager.darwinModules.home-manager ];
      };

      pkgs = import nixpkgs {
        system = "x86_64-darwin";
      };
    in
    {
      darwinConfigurations =
        {
          "OF060VV4A8HTD6F" = inputs.darwin.lib.darwinSystem
            {
              modules = [
                ./machines/work.nix
                darwinDefaults
              ];
              inputs = { inherit neovim-nightly; };
            };
        };

      nixosConfigurations.loki = inputs.nixos.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./machines/loki/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.janders223 = import ./machines/home.nix;
          }
        ];
      };

      devShell.x86_64-darwin = import ./shell.nix { inherit pkgs; };
    };
}
