{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:

{
  imports = [
    ../components/git/actions/remote-nix.nix
  ];

  networking = {
    hostName = "runner";
  };
}
