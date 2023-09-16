# This is used as `services.xserver.windowManager.xmonad.config` does not work properly
{ inputs, lib, config, pkgs, ... }: {
  home.file.".config/xmonad/xmonad.hs".source = ./xmonad.hs;
}
