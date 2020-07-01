{ config, lib, pkgs, ... }:

let homeDir = builtins.getEnv ("HOME");
in {
  imports = lib.attrValues (import ../../modules);
  local.machineName = "OF060VV4A8HTD6X";
  local.userName = "kon8522";
  local.userEmail = "jim.anders@kroger.com";
}
