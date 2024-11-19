
{
  description = "A Nix-flake-based Node.js development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self , nixpkgs ,... }:
  let
    # system should match the system you are running on
    system = "x86_64-linux";
  in {
    devShells."${system}".default =
    let
      pkgs = import nixpkgs { inherit system; };
    in pkgs.mkShell {
      # create an environment with multiple nodejs_, pnpm, and yarn
      packages = with pkgs; [
        nodejs_18
        nodejs_23
        (yarn.override { nodejs = nodejs_23; })
      ];

      shellHook = ''
        echo "node `${pkgs.nodejs}/bin/node --version`"
      '';
    };
  };
}
