{

  description = "NixOS deployment flake";

  inputs = {
    nixpkgs-stable = {
      url = "nixpkgs/nixos-25.11";
    };

    nixpkgs-stable-pinned = {
      url = "github:NixOS/nixpkgs/0c88e1f2bdb9"; # 25.11
    };

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    colmena.url = "github:zhaofengli/colmena";
  };

  outputs =
    {
      self,
      nixpkgs-stable-pinned,
      nixpkgs-unstable,
      colmena,
      ...
    }@inputs:
    let
      system = "x86_64-linux";

      pkgs-unstable = import nixpkgs-unstable {
        system = "${system}";
        config.allowUnfree = true;
      };

    in
    {
      colmenaHive = colmena.lib.makeHive {
        meta = {
          nixpkgs = (import nixpkgs-stable-pinned) {
            config.allowUnfree = true;
            system = "x86_64-linux";
            overlays = [ ];
          };

          specialArgs = {
            inherit pkgs-unstable;
          };

        };

        # Base configuration for all hosts
        defaults =
          { pkgs, ... }:
          {

            imports = [
              ./hw/host.nix # if you need to use disparate hw/orchestration, delete this and move it to /hosts/* separately
              ./components/base.nix
              ./components/ssh/all.nix
            ];
          };

        # Managed hosts
        "git.example.net" =
          { name, nodes, ... }:
          {
            deployment.targetHost = "192.168.0.1";
            imports = [ ./hosts/git.example.net.nix ];
          };

        "runner.example.net" =
          { name, nodes, ... }:
          {
            deployment.targetHost = "192.168.0.2";
            imports = [ ./hosts/runner.example.net.nix ];
          };

        "docs.example.net" =
          { name, nodes, ... }:
          {
            deployment = {
              targetHost = "192.168.0.3";
            };
            imports = [ ./hosts/docs.example.net.nix ];

          };

      };

      devShells.${system}.default =

        pkgs-unstable.mkShell {

          packages = [
            colmena.packages.${system}.colmena
          ];

          shellHook = ''
            printf " `${colmena.packages.${system}.colmena}/bin/colmena --version`"
          '';
        };

    };
}
