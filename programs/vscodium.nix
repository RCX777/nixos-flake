{ inputs, lib, config, pkgs, ... }: {
  programs.vscode = {
    enable  = true;
    package = pkgs.vscodium;

    haskell.enable       = true;
    mutableExtensionsDir = true;
  };
}
