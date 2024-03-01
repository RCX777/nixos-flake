{
  description = "System config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @inputs: let
    inherit (self) outputs;
  in {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };

        modules = [
          ./system.nix
          ./hardware/laptop.nix
          ./host-specific/laptop.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs   = true;
            home-manager.useUserPackages = true;
            home-manager.users.rcx       = import ./home.nix;
          }
        ];
      };

      pc = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };

        modules = [
          ./system.nix
          ./hardware/pc.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs   = true;
            home-manager.useUserPackages = true;
            home-manager.users.rcx       = import ./home.nix;
          }
        ];
      };
    };
  };
}
