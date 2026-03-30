{
  description = "gianluur's NixOS Flake (ultimate workstation)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel/release";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snappy-switcher = {
      url = "github:OpalAayan/snappy-switcher";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nix-cachyos-kernel, dms, dms-plugin-registry, dgop, snappy-switcher, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgsUnstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
  in
  {
    nixosConfigurations.workstation = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs pkgsUnstable; };
      modules = [
        ({ ... }: {
          nixpkgs = {
            config.allowUnfree = true;
            overlays = [
              (_final: _prev: { unstable = pkgsUnstable; })
              (_final: prev: {
                unstable = pkgsUnstable;
                dgop = inputs.dgop.packages.${prev.system}.default;
              })
              nix-cachyos-kernel.overlays.default
            ];
          };
        })
        ./hosts/workstation/default.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.shxqow = import ./home/shxqow.nix;
          home-manager.extraSpecialArgs = { inherit inputs pkgsUnstable; };
        }
      ];
    };
  };
}
