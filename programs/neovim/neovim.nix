{ inputs, lib, config, pkgs, ... }: {
  programs.neovim = {
    enable = true;

    viAlias  = true;
    vimAlias = true; 
  };

  home = {
    file."${config.xdg.configHome}/nvim" = {
      recursive = true;
      source    = ./config;
    };

    packages = with pkgs; [
      # Common language servers
      # C
      clang-tools
      clang

      # Lua
      lua-language-server

      # Nix
      nixd

      # Haskell
      haskell-language-server

      # Rust
      rust-analyzer

      # Python
      python311Packages.python-lsp-server
      nodePackages.pyright

      # Bash
      nodePackages.bash-language-server
    ];
  };
}

