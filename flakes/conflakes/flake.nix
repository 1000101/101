{
  description = "conflakes";

  inputs = {
    nixpkgs-stable.url = "nixpkgs/nixos-25.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  # to both update flakes and upgrade run
  # nix flake update --flake <pathtoflake> && sudo nixos-rebuild switch --flake <pathtoflake> (--impure) switch

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        uniza = nixpkgs.lib.nixosSystem {
          # ^ depends on hostname
          # nixos-rebuild --flake /root/101/flakes/conflakes/.#uniza --impure switch
          # ^ hostname agnostic, you can rename to uniza to whatever... or define more configurations
          system = "x86_64-linux";
          modules = [
            /etc/nixos/configuration.nix
            # need to use --impure for /etc ^^^
            # # nixos-rebuild --flake ~/101/flakes/conflakes/.#nixos --impure switch
            #
            # alternatively, copy out configuration.nix somewhere else and use that:
            #/root/101/configuration/configuration.nix
          ];
        };
      };
    };
}
