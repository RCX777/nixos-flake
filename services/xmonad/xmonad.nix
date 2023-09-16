{ inputs, lib, config, pkgs, ... }: {
  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;

    # Somehow if this is done, if I update `xmonad.hs` and then rebuild the system,
    # the changes do not apply to xmonad.
    # TODO: Research this better
    # config = ./xmonad.hs;
  };
}
