# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:


{
  imports =
    [
      # Include the results of the hardware scan.
      <nixpkgs/nixos/modules/virtualisation/openstack-config.nix>
      # include more configs
    ];

  # copy the configuration.nix into /run/current-system/configuration.nix
  system.copySystemConfiguration = true;

  # /etc/hosts is RO ;)
  networking.hosts = {
    #  "132.123.1.22" = [ "tralala.io" ];
  };

  nix = {
    extraOptions = ''
      experimental-features = nix-command
      extra-experimental-features = flakes
    '';
  };

  # Enable latest kernel updates
  boot.kernelPackages = pkgs.linuxPackages_latest;

  environment.systemPackages = with pkgs; [
    # System utilities
    btop
    gnupg
    nano
    vim
    wget
  ];

  # Networking setup
  networking = {
    # hostname, duh
    hostName = "uniza";

    # Enable NetworkManager
    networkmanager.enable = true;

    # general network settings
    firewall = {
      enable = true;
      allowPing = true;
      # Port 22 is already open through setting openFirewall = true;
      allowedTCPPorts = [ 80 443 ];
    };
  };


  # List services that you want to enable:

  # ssh-keygen -t ed25519
  # pubkey goes here:
  users.extraUsers.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3Nz... aaa@bbb.com"
  ];

  services.openssh = {
    enable = true;
    permitRootLogin = lib.mkDefault "yes";
    passwordAuthentication = lib.mkDefault false;
    openFirewall = true;
  };

  # Sets let's encrypt settings for the Nginx below
  # security.acme.acceptTerms = true;
  # security.acme.defaults.email = "mymail@example.org";

  # Enables Nginx with voluntary recommended settings and Let's Enecrypt
  services.nginx = {
    enable = false;
    # recommendedGzipSettings = true;
    # recommendedOptimisation = true;
    # recommendedProxySettings = true;
    # recommendedTlsSettings = true;
    virtualHosts."example.org" = {
      # enableACME = true;
      # forceSSL = true;
      locations."/".root = "${pkgs.nginx}/html";
    };
  };

  # Limit journal size
  services.journald = {
    extraConfig = "SystemMaxUse=500M";
  };

  # Set your time zone.
  time.timeZone = "Europe/Bratislava";

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "24.11"; # Did you read the comment?

}
