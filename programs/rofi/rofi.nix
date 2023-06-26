{ inputs, lib, config, pkgs, ... }: {
  programs.rofi = {
    enable = true;
    theme  = ./catppuccin-mocha.rasi;
  };

  home.file."$XDG_CONFIG_HOME/rofi/config.rasi".source = ./config.rasi:
}
