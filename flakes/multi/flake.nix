{
  description = "A Nix-flake-based Node.js development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self , nixpkgs ,... }:
  let
    # system should match the system you are running on
    system = "x86_64-linux";
    # globally define packages
    # https://discourse.nixos.org/t/using-nixpkgs-legacypackages-system-vs-import/17462/5
    pkgs = import nixpkgs { inherit system; };
  in
  {
    devShells."${system}" =
    {
      firstshell =
        pkgs.mkShell {
          # create an environment with multiple nodejs_, and yarn
          packages = with pkgs; [
            nodejs_18
            nodejs_23
            (yarn.override { nodejs = nodejs_23; })
          ];

          shellHook = ''
            echo "node `${pkgs.nodejs}/bin/node --version`"
          '';
        };

      secondshell =
        pkgs.mkShell {
          # create an environment with multiple nodejs_, and yarn
          packages = with pkgs; [
            nodejs_18
            nodejs_23
            (yarn.override { nodejs = nodejs_23; })
          ];

          shellHook = ''
            echo "node `${pkgs.nodejs_22}/bin/node --version`"
          '';
        };
    };
  };
}
