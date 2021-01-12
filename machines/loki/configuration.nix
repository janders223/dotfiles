{ modulesPath, lib, ... }:
{
  imports = lib.optional (builtins.pathExists ./do-userdata.nix) ./do-userdata.nix ++ [
    (modulesPath + "/virtualisation/digital-ocean-config.nix")
  ];

  services.openssh = {
    ports = [ 3518 ];
    passwordAuthentication = false;
  };
}
