{ inputs, lib, config, pkgs, ... }: {
  home.file.".config/polybar/config.ini".source = ./config.ini;
}
