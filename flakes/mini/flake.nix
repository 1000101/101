{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells."${system}".default =

        pkgs.mkShell {

          packages = with pkgs; [
            nodejs_22
            nodejs_24
            (yarn.override { nodejs = nodejs_24; })
          ];

          shellHook = ''
            printf "node `${pkgs.nodejs}/bin/node --version`"
          '';
        };
    };
}
