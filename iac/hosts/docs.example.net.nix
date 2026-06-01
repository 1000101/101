{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:

{
  imports = [
    ../components/web/nginx.nix
    ../components/ssh/runner.nix # allow publish from runner

  ];

  networking = {
    hostName = "docs";
  };

  services.nginx = {
    enable = true;

    virtualHosts."docs.example.net" = {
      locations."/".root = "/var/lib/docs";
    };

  };

}
