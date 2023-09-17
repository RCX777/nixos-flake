{ inputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # Programs
    ./programs/git.nix
    ./programs/gpg.nix
    ./programs/ssh.nix
    ./programs/zsh.nix
    ./programs/rofi/rofi.nix
    ./programs/polybar/polybar.nix
    ./programs/vscodium.nix

    # Check `services/xmonad/xmonad.nix` for details about this `hacky` approach
    ./services/xmonad/xmonad-config-hack.nix
  ];

  home = {
    username      = "rcx";
    homeDirectory = "/home/rcx";

    sessionVariables = rec {
      # Use GPG-agent for SSH
      SSH_AUTH_SOCK = "/run/user/1000/gnupg/S.gpg-agent.ssh";

      HISTFILE = "${config.xdg.stateHome}/bash/history";

      CUDA_CACHE_PATH = "${config.xdg.cacheHome}/nv";

      _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${config.xdg.configHome}/java";

      XCOMPOSECACHE = "${config.xdg.cacheHome}";
      XCOMPOSEFILE  = "${XCOMPOSECACHE}/.XCompose";

      __GL_SHADER_DISK_CACHE_PATH = "${config.xdg.cacheHome}";

      ERRFILE = "${config.xdg.cacheHome}/X11/xsession-errors";
    };

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
