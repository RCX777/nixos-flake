# This is used as `services.xserver.windowManager.xmonad.config` does not work properly
{ config, ... }: {
  home.file = {
    "${config.xdg.configHome}/xmonad/xmonad.hs".source = ./xmonad.hs;
    "${config.xdg.configHome}/xmonad/light.sh".source = ./light.sh;
  };
}
