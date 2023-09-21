{ inputs, lib, config, pkgs, ... }: {
  programs.eww = {
    enable    = true;
    configDir = ./config;
  };
}
