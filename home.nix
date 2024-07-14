{ pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    ## Programs ##
    #
    # User shell & config
    ./programs/zsh.nix
    ./programs/direnv.nix

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

    # Text Editors
    ./programs/helix.nix
    ./programs/neovim/neovim.nix

    # Web browser
    ./programs/firefox.nix
    ./programs/chromium.nix

    # Shell prompt
    ./programs/starship.nix

    # Terminal productivity tools
    ./programs/zoxide.nix
    ./programs/tmux.nix

    ## Check `services/xmonad/xmonad.nix` for details about this `hacky` approach
    ./services/xmonad/xmonad-config-hack.nix

    # Custom ".desktop" files
    ./desktop-entries/custom.nix
  ];

  home = {
    username      = "rcx";
    homeDirectory = "/home/rcx";

    packages = with pkgs; [
      # Sound control
      pavucontrol
      pamixer

      # Media
      mpv

      # Web & comm
      (discord.override { withOpenASAR = true; })
      teams-for-linux

      # Gaming-related
      prismlauncher
      (steam.override { extraPkgs = (pkgs: [ gamemode mangohud ]); })
      (lutris.override { extraPkgs = (pkgs: [ gamescope gamemode mangohud ]); })

      # Utilities
      lsd
      ripgrep
      procs
      fd
      bat
      tmux
      fzf
      jq

      # Compression
      zip
      unzip
      p7zip

      # Networking
      inetutils
      wget
      nmap
      fragments

      # Screenshot
      scrot

      # WM/X11 related
      wmctrl
      xdotool
      xclip

      # System info
      pciutils
      htop

      # Pdf viewer
      zathura

      # Emulation
      wineWowPackages.stagingFull
    ];

    file = {
      "Desktop/media/images/wallpapers" = {
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
