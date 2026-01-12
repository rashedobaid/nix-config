{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
    let
      lib = nixpkgs.lib;

      importAll = dir:
        builtins.attrValues (builtins.mapAttrs
          (name: _: dir + "/${name}")
          (lib.filterAttrs (name: _: lib.hasSuffix ".nix" name) (builtins.readDir dir)));
    in
    {
      darwinConfigurations."macbookpro" = nix-darwin.lib.darwinSystem {
        modules =
          (importAll ./modules/common) ++
          (importAll ./modules/darwin) ++
          (importAll ./modules/darwin/lunaria) ++
          [
            home-manager.darwinModules.home-manager
            {
              home-manager.useUserPackages = true;
              home-manager.users.rashedobaid = import ./users/rashedobaid/default.nix;
            }
          ];
      };
      nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
        modules =
          (importAll ./modules/common) ++
          (importAll ./modules/nixos) ++
          [
            home-manager.nixosModules.home-manager
            {
              home-manager.useUserPackages = true;
              home-manager.users.rashedobaid = import ./users/rashedobaid/default.nix;
            }
          ];
      };
    };
}
