{ inputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # Programs
    ./programs/git.nix
    ./programs/gpg.nix
    ./programs/ssh.nix
  ];

  home = {
    username      = "rcx";
    homeDirectory = "/home/rcx";
  };

  home.packages = with pkgs; [
    haskellPackages.haskell-language-server
    haskellPackages.haskell-debug-adapter

    firefox
    lutris
    discord
  ];
  
  # Enable home-manager and git
  programs.home-manager.enable = true;

  programs.neovim = {
    enable        = true;
    defaultEditor = true;
    vimAlias      = true;

    plugins = with pkgs.vimPlugins; [
      haskell-tools-nvim
      plenary-nvim
      telescope-nvim
      nvim-dap
    ];
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
