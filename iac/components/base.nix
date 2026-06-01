{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    # System utilities
    btop
    gnupg
    nano
    vim
    wget
  ];

  # SERVICES

  # networking
  networking = {

    #set domain
    domain = "example.net";

    # enable NetworkManager
    networkmanager.enable = true;

    # general firewall settings
    firewall = {
      enable = true;
      allowPing = true;
    };
  };

  # SSH
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = lib.mkDefault "yes";
      PasswordAuthentication = lib.mkDefault false;
    };
    openFirewall = true;
  };

  # Limit journal size
  services.journald = {
    extraConfig = "SystemMaxUse=500M";
  };

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # nix settings
  nix = {
    extraOptions = ''
      experimental-features = nix-command
      extra-experimental-features = flakes
    '';
  };

  # disable docs so it doesn't build
  documentation = {
    enable = lib.mkDefault false;
    nixos.enable = lib.mkDefault false;
  };

}
