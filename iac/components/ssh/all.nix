{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:
{
  users.extraUsers.root.openssh.authorizedKeys.keys = [
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIIXKWyuLsP1foZdfuuyQ/BZFYvflhxi/U2j/01dzTstrAAAABHNzaDo= 1000101@1000101"
  ];
}
