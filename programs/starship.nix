{ inputs, lib, config, pkgs, ... }: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}

