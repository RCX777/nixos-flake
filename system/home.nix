{ pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    ## Programs ##
    #
    ../programs/shells/zsh.nix
    # ../programs/shells/bash.nix

    ../programs/cli/direnv.nix
    ../programs/cli/git.nix
    # Note! Main gpg key is also used as ssh via gpg-agent
    ../programs/cli/gpg.nix
    ../programs/cli/ssh.nix
    ../programs/cli/starship.nix
    ../programs/cli/zoxide.nix
    ../programs/cli/tmux.nix

    ../programs/terminals/alacritty/alacritty.nix

    ../programs/editors/helix.nix
    ../programs/editors/neovim/neovim.nix

    ../programs/browsers/firefox.nix
    ../programs/browsers/chromium.nix

    ../programs/desktop/rofi/rofi.nix
    ../programs/desktop/eww/eww.nix

    # used such that the xmonad configuration files are included
    # via the `home.file.<path>.source`
    ./xserver/xmonad/xmonad-config-hack.nix

    # Custom ".desktop" files
    ./desktop-entries.nix
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
      "desktop/media/images/wallpapers" = {
        source    = ../wallpapers;
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
