{ inputs, lib, config, pkgs, ... }: {
  programs.firefox = {
    enable = true;

    # TODO: override wrapper such that ".mozilla" is
    # created inside $XDG_CONFIG_HOME instead of $HOME
    package = pkgs.firefox;
  };
}

