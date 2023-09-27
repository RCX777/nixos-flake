{ inputs, custom, lib, config, pkgs, ... }: {
  programs.direnv = {
    enable     = true;
    
    nix-direnv = {
      enable = true;
    };

    enableZshIntegration = true;
  };
}

