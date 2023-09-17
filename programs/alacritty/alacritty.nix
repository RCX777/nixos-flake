{ inputs, lib, config, pkgs, ... }: {
  programs.alacritty = {
    enable = true;
  };

  home.file."${config.xdg.configHome}/alacritty/alacritty.yml".source = ./alacritty.yml;
}
