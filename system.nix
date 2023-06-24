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

    # Services (xserver, picom, etc..i.)
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

  security.rtkit.enable = true;

  # Environment packages/variables
  environment.binsh = "${pkgs.dash}/bin/dash";
  environment.sessionVariables = rec {
    SSH_AUTH_SOCK = "/run/user/1000/gnupg/S.gpg-agent.ssh";
  };
  environment.systemPackages = with pkgs; [
    dash
    killall

    haskellPackages.xmobar
    xdotool
    feh
    ghc
    rofi

    man-pages
    man-pages-posix

    htop
    alacritty
  ];

  # System-wide fonts
  fonts.fonts = with pkgs; [
    font-awesome
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    noto-fonts-emoji
    overpass
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
