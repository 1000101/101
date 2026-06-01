{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:
{

  nix.settings.trusted-users = [ "gitea-runner" ];
  users.users.gitea-runner = {
    isNormalUser = true;
  };

  services.gitea-actions-runner = {
    package = pkgs-unstable.forgejo-runner;
    instances."runner-nix.${config.networking.hostName}.${config.networking.domain}" = {
      enable = true;
      name = "${config.networking.hostName}.${config.networking.domain}";
      tokenFile = "/etc/secrets/runner/forgejo.token";
      url = "https://git.example.net/";
      labels = [
        "nix:host" # bare nix runner
      ];
      hostPackages = with pkgs; [
        bash
        coreutils
        gawk
        gitMinimal
        gnused
        nodejs
        wget
        pkgs-unstable.zensical
        nix
        openssh
      ];
      settings = { };
    };

  };
}
