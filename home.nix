{ inputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    ## Programs ##
    #
    # User shell & config
    ./programs/zsh.nix

    # Code versioning system
    ./programs/git.nix

    # Note! Main gpg key is also used as ssh via gpg-agent
    ./programs/gpg.nix
    ./programs/ssh.nix

    # Application launcher (dmenu equivalent)
    ./programs/rofi/rofi.nix

    # Top-bar & widgets
    ./programs/eww/eww.nix

    # Terminal emulator
    ./programs/alacritty/alacritty.nix

    # Text Editor (dev)
    ./programs/vscodium.nix

    ## Check `services/xmonad/xmonad.nix` for details about this `hacky` approach
    ./services/xmonad/xmonad-config-hack.nix
  ];

  home = {
    username      = "rcx";
    homeDirectory = "/home/rcx";

    packages = with pkgs; [
      # Sound control
      pavucontrol
      pamixer

      # Dev
      direnv
      gnumake
      python3

      # Web & comm
      firefox
      (discord.override { withOpenASAR = true; })

      # Gaming-related
      prismlauncher
      lutris
      steam

      # Misc utilities
      flameshot
      xdotool
      wmctrl
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
