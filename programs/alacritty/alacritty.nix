{ config, ... }: {
  programs.alacritty = {
    enable = true;
  };

  home.file."${config.xdg.configHome}/alacritty/alacritty.toml".source = ./alacritty.toml;
}
