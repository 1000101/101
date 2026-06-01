{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:

{
  imports = [
    ../components/git/git.nix
    ../components/web/nginx.nix
  ];

  networking = {
    hostName = "git";
  };
}
