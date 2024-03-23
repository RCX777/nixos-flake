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

  home.packages = with pkgs; [
    # Common language servers
    # C
    clang-tools
    clang
    
    # Lua
    lua-language-server
  ];
}
