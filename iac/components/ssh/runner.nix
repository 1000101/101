{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:
{
  users.extraUsers.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKo8nU+uWxVFiGLSvlLO7DU0Z/digzlHdgQG0Ocz4Oag root@runner.example.net"
  ];
}
