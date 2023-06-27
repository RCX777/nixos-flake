{ inputs, lib, config, pkgs, ... }: {
  programs.neovim = {
    enable        = true;
    defaultEditor = true;
    vimAlias      = true;

    plugins = with pkgs.vimPlugins; [
      haskell-tools-nvim
      plenary-nvim
      telescope-nvim
      telescope_hoogle
      nvim-dap
      nerdtree
      nerdtree-git-plugin
      catppuccin-nvim
    ];
  };
}
