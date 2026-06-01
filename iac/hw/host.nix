{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:

{

  boot = {
    growPartition = true;
    loader.grub = {
      device = "/dev/sda";
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    autoResize = true;
    fsType = "ext4";
  };
}
