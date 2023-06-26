{ inputs, lib, config, pkgs, ... }: {
  programs.rofi = {
    enable = true;
    theme  = ./catppuccin-mocha.rasi;
  };
}
