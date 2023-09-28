# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ inputs, lib, config, pkgs, ... }: {
  imports = [
    # Hardware-specific configuration
    ./hardware.nix

    # System users (user-specific configuration is stored in `home.nix`)
    ./users.nix

    # System programs configuration
    # (e.g. gnupg.agent, required for using GPG keys while doing SSH)
    ./programs/gnupg-agent.nix

    # Services (xserver, picom, etc...)
    ./services/xserver.nix
    ./services/openssh.nix
    ./services/picom.nix
    ./services/pipewire.nix
    ./services/pcscd.nix
  ];

  nixpkgs = {
    overlays = [ ];

    config = {
      allowUnfree = true;
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store   = true;
    };
  };

  networking.networkmanager.enable = true;
  networking.hostName = "nixos";

  time.timeZone = "Europe/Bucharest";

  security = {
    rtkit.enable = true;

    sudo = {
      enable = true;

      extraConfig = ''
        # Show asterisks when typing password
        Defaults pwfeedback
      '';
    };
  };

  environment = {
    binsh = "${pkgs.dash}/bin/dash";

    shells = with pkgs; [ zsh ];

    systemPackages = with pkgs; [
      dash
      man-pages
      man-pages-posix
    ];

    sessionVariables = rec {
      XDG_CACHE_HOME  = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME   = "$HOME/.local/share";
      XDG_STATE_HOME  = "$HOME/.local/state";

      XCOMPOSECACHE   = "${XDG_CACHE_HOME}";
      XCOMPOSEFILE    = "${XCOMPOSECACHE}/.XCompose";

      # Use GPG-agent for SSH
      SSH_AUTH_SOCK = "/run/user/1000/gnupg/S.gpg-agent.ssh";

      CUDA_CACHE_PATH = "${XDG_CACHE_HOME}/nv";
      __GL_SHADER_DISK_CACHE_PATH = "${XDG_CACHE_HOME}";

      _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${XDG_CONFIG_HOME}/java";

      ERRFILE = "${XDG_CACHE_HOME}/X11/xsession-errors";
    };
  };

  # System-wide fonts
  fonts.fonts = with pkgs; [
    font-awesome
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    helvetica-neue-lt-std
    noto-fonts-emoji
    overpass
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
