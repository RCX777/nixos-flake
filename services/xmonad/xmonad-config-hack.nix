# This is used as `services.xserver.windowManager.xmonad.config` does not work properly
{ inputs, lib, config, pkgs, ... }: {
  home.file."${config.xdg.configHome}/xmonad/xmonad.hs".source = ./xmonad.hs;
}
