{
  description = "A Nix-flake-based Node.js development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgsUnstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgsStable-old.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgsUnstable,
      nixpkgsStable-old,
      ...
    }:
    let
      system = "x86_64-linux";

      # import pkgs once, all in the same let
      pkgs = import nixpkgs { inherit system; };
      pkgsUnstable = import nixpkgsUnstable { inherit system; };
      pkgsStable = import nixpkgsStable-old { inherit system; };

      firstshell = pkgs.mkShell {
        packages = with pkgsStable; [
          nodejs_20
          nodejs_22
        ];
        shellHook = ''
          printf "stable node: `${pkgsStable.nodejs}/bin/node --version`"
        '';
      };

      secondshell = pkgs.mkShell {
        packages = with pkgsUnstable; [
          nodejs_22
          nodejs_24
          (yarn.override { nodejs = nodejs_20; })
        ];
        shellHook = ''
          printf "unstable node: `${pkgsUnstable.nodejs}/bin/node --version`\n\n"
          printf "yarn node unstable version: `${pkgsUnstable.yarn}/bin/yarn node --version` \n\n"
          printf "yarn node overriden version: `yarn node --version`"
        '';
      };
    in
    {
      devShells.${system} = {
        default = firstshell;
        firstshell = firstshell;
        secondshell = secondshell;
      };
    };
}
