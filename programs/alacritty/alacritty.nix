{ inputs, lib, config, pkgs, ... }: {
  programs.alacritty = {
    enable   = true;
    settings = ./alacritty.yml;
  }
}
