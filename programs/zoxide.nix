{ inputs, lib, config, pkgs, ... }: {
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}

