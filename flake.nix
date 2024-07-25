{
  description = "System config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pixgrab = {
      url = "github:RCX777/pixgrab";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    lanzaboote,
    ...
  } @inputs: let
    mkHost = name: nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };

      modules = [
        ./system/system.nix
        lanzaboote.nixosModules.lanzaboote
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs   = true;
          home-manager.useUserPackages = true;
          home-manager.users.rcx       = import ./system/home.nix;
        }
      ] ++ nixpkgs.lib.mapAttrsToList
            (k: _: ./. + ("/hosts/${name}/" + k))
            (builtins.readDir ./hosts/${name});
    };
  in {
    nixosConfigurations = builtins.mapAttrs
                            (k: _: mkHost k)
                            (builtins.readDir ./hosts);
  };
}

