{ inputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # Programs
    ./programs/git.nix
    ./programs/gpg.nix
    ./programs/ssh.nix
    ./programs/nvim.nix
    ./programs/rofi/rofi.nix
    ./programs/xmobar/xmobar.nix
    ./programs/vscodium.nix
  ];

  home = {
    username      = "rcx";
    homeDirectory = "/home/rcx";
  };

  home.file."Media/Images/Wallpapers" = {
    source    = ./wallpapers;
    recursive = true;
  };

  home.packages = with pkgs; [
    haskellPackages.haskell-language-server
    haskellPackages.haskell-debug-adapter
    haskellPackages.hoogle

    ihp-new # For generating new IHP projects
    direnv
    gnumake

    firefox
    lutris
    steam
    (discord.override { withOpenASAR = true; })

    prismlauncher
  ];
  
  # Enable home-manager and git
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
