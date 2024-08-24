{ pkgs, config, lib, ... }: {
  services.xserver.windowManager.xmonad = {
    enable = config.services.xserver.enable;
    enableContribAndExtras = true;

    # Somehow if this is done, if I update `xmonad.hs` and then rebuild the system,
    # the changes do not apply to xmonad.
    # TODO: Research this better
    # config = ./xmonad.hs;
  };

  environment = {
    systemPackages = lib.mkIf config.services.xserver.enable (with pkgs; [
      # Used to kill spawned processes on restart
      killall
      # Used to set the desktop background
      feh
    ]);
  };
}
