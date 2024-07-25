# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./users.nix

    ./display-managers/lightdm/lightdm.nix

    ./xserver/xserver.nix

    ./sound/pipewire.nix

    ./openssh.nix
    ./pcscd.nix

    ../programs/cli/gnupg-agent.nix
  ];

  nixpkgs = {
    overlays = [ ];

    config = {
      allowUnfree = true;
      cudaSupport = true;
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

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than +4";
    };
  };

  networking.networkmanager.enable = true;
  networking.hostName = "nixos";

  time = {
    timeZone = "Europe/Bucharest";
    hardwareClockInLocalTime = true;
  };

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
      sbctl

      # TODO: somehow move this to `home.nix` in the future
      inputs.pixgrab.packages.${system}.default
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

      HISTFILE = "${XDG_STATE_HOME}/bash/history";

      PYTHON_HISTORY = "${XDG_STATE_HOME}/python/history";
      PYTHONPYCACHEPREFIX = "${XDG_CACHE_HOME}/python";
      PYTHONUSERBASE = "${XDG_DATA_HOME}/python";
      IPYTHONDIR = "${XDG_CONFIG_HOME}/ipython";
      JUPYTER_CONFIG_DIR = "${XDG_CONFIG_HOME}/jupyter";
    };
  };

  # System-wide fonts
  fonts.packages = with pkgs; [
    font-awesome
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    helvetica-neue-lt-std
    noto-fonts-emoji
    overpass
  ];

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [(pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd];
        };
      };
    };
    spiceUSBRedirection.enable = true;

    docker = {
      enable = true;
      enableNvidia = true;
      extraOptions = ''
        --add-runtime nvidia=/run/current-system/sw/bin/nvidia-container-runtime
      '';
    };
  };

  programs = {
    virt-manager.enable = true;

    gamemode = {
      enable = true;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
