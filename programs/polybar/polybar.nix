{ inputs, lib, config, pkgs, ... }: {
  home.file."${config.xdg.configHome}/polybar/config.ini".source = ./config.ini;
}
