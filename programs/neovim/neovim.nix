{ inputs, lib, config, pkgs, ... }: {
  programs.neovim = {
    enable = true;

    viAlias  = true;
    vimAlias = true; 
  };

  home.file."${config.xdg.configHome}/nvim" = {
    recursive = true;
    source    = ./config;
  };
}
