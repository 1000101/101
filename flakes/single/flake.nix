{
  description = "A Nix-flake-based Node.js development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    n00b-nixpkgs-stable.url = "nixpkgs/nixos-25.05";
    #n00b-nixpkgs-stable-μεγαολδ.url = "github:NixOS/nixpkgs/7848cd8c982f";
    n00b-nixpkgs-stable-bugged.url = "github:NixOS/nixpkgs/9da7f1cf7f8a";
    n00b-nixpkgs-stable-megaold.url = "github:NixOS/nixpkgs/9a0b14b097d6";
  };

  outputs =
    {
      self,
      nixpkgs,
      n00b-nixpkgs-stable,
      #n00b-nixpkgs-unstable,
      n00b-nixpkgs-stable-bugged,
      n00b-nixpkgs-stable-megaold,
      ...
    }:
    let
      # system should match the system you are running on
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      pkgs-n00b-stable = import n00b-nixpkgs-stable { inherit system; };
      pkgs-n00b-stable-bugged = import n00b-nixpkgs-stable-bugged { inherit system; };
      pkgs-n00b-stable-megaold = import n00b-nixpkgs-stable-megaold { inherit system; };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          pkgs.openssh
          pkgs-n00b-stable.openssh
          pkgs-n00b-stable-bugged.openssh
          pkgs-n00b-stable-megaold.openssh
        ];

        shellHook = ''
          printf "pkgs: \n"
          printf "`${pkgs.openssh}/bin/ssh -V`"
          printf "`which ${pkgs.openssh}/bin/ssh`"
          printf "\n\n"
          printf "pkgs-n00b-stable: \n"
          printf "`${pkgs-n00b-stable.openssh}/bin/ssh -V`"
          printf "`which ${pkgs-n00b-stable.openssh}/bin/ssh`"
          printf "\n\n"
          printf "pkgs-n00b-stable-bugged: \n"
          printf "`${pkgs-n00b-stable-bugged.openssh}/bin/ssh -V`"
          printf "`which ${pkgs-n00b-stable-bugged.openssh}/bin/ssh`"
          printf "\n\n"
          printf "pkgs-n00b-stable-μεγαold: \n"
          printf "`${pkgs-n00b-stable-megaold.openssh}/bin/ssh -V`"
          printf "`which ${pkgs-n00b-stable-megaold.openssh}/bin/ssh`"
        '';

      };
    };
}
