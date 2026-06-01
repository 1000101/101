{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:
{
  services.nginx = {
    enable = true;

    # use generally recommended settings
    recommendedTlsSettings = true;
    recommendedOptimisation = true;

    # use SSL for every default virtualconfig
    virtualHosts."${config.networking.hostName}.${config.networking.domain}" = {
      forceSSL = true;
      sslCertificate = "/etc/secrets/ssl/example.net.pem";
      sslCertificateKey = "/etc/secrets/ssl/example.net.key";
    };

  };

  networking.firewall = {
    allowedTCPPorts = [
      443
    ];
  };
}
