{
  description = "System config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.3.0";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    pixgrab = {
      url = "github:RCX777/pixgrab";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    lanzaboote,
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
          lanzaboote.nixosModules.lanzaboote
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
          lanzaboote.nixosModules.lanzaboote
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
