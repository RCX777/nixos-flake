{ inputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # Programs
    ./programs/zsh.nix
    ./programs/git.nix
    ./programs/gpg.nix
    ./programs/ssh.nix
    ./programs/rofi/rofi.nix
    ./programs/polybar/polybar.nix
    ./programs/alacritty/alacritty.nix
    ./programs/vscodium.nix

    # Check `services/xmonad/xmonad.nix` for details about this `hacky` approach
    ./services/xmonad/xmonad-config-hack.nix
  ];

  home = {
    username      = "rcx";
    homeDirectory = "/home/rcx";

    packages = with pkgs; [
      (polybar.override { pulseSupport = true; })
      pavucontrol
      pamixer

      direnv
      gnumake

      firefox
      lutris
      steam
      (discord.override { withOpenASAR = true; })
      flameshot # Screenshot utility

      prismlauncher
    ];

    file = {
      "Media/Images/Wallpapers" = {
        source    = ./wallpapers;
        recursive = true;
      };
    };
  };

  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
