{ pkgs, modulesPath, lib, ... }:
{
  imports = lib.optional (builtins.pathExists ./do-userdata.nix) ./do-userdata.nix ++ [
    (modulesPath + "/virtualisation/digital-ocean-config.nix")
  ];

users.users.janders223.isNormalUser = true;

nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
   };

  services.openssh = {
    ports = [ 3518 ];
    passwordAuthentication = false;
  };

#systemd.services.home-manager-janders223.preStart = ''
#      # XXX: Dummy nix-env command to work around https://github.com/rycee/home-manager/issues/948
#      ${pkgs.nix}/bin/nix-env -i -E {}
#'';
}
