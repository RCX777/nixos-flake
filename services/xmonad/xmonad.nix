{ inputs, lib, config, pkgs, ... }: {
  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = ./xmonad.hs
  }
}
