{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:
{

  services.forgejo = {
    enable = true;
    package = pkgs.forgejo; # pkgs.forgejo-lts;
    database.type = "postgres";
    # Enable support for Git Large File Storage
    lfs.enable = true;
    settings = {
      server = {
        DOMAIN = "${config.networking.domain}";
        # You need to specify this to remove the port from URLs in the web UI.
        ROOT_URL = "https://${config.networking.hostName}.${config.networking.domain}/";
        HTTP_PORT = 3000;
        SSH_PORT = lib.head config.services.openssh.ports; # SSH support
      };
      # You can temporarily allow registration to create an admin user.
      service.DISABLE_REGISTRATION = false;
      # Add support for actions, based on act: https://github.com/nektos/act
      actions = {
        ENABLED = true;
        DEFAULT_ACTIONS_URL = "github";
      };
      # Sending emails is completely optional
      # You can send a test email from the web UI at:
      # Profile Picture > Site Administration > Configuration >  Mailer Configuration
      mailer = {
        ENABLED = true;
        SMTP_ADDR = "mail.example.com";
        FROM = "noreply@${config.networking.domain}";
        USER = "noreply@${config.networking.domain}";
      };
    };
    secrets = {
      mailer.PASSWD = "/etc/secrets/forgejo-mailer-password"; # config.age.secrets.forgejo-mailer-password.path;
    };
  };

  services.nginx = {
    virtualHosts."${config.networking.hostName}.${config.networking.domain}" = {
      extraConfig = ''
        client_max_body_size 512M;
      '';
      locations."/".proxyPass =
        "http://localhost:${toString config.services.forgejo.settings.server.HTTP_PORT}";
    };

  };

}
