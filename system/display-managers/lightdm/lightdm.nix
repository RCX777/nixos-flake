{ ... }: {
  services.xserver.displayManager.lightdm = {
    extraSeatDefaults = ''
      user-session = none+xmonad
    '';
    greeters.mini = {
      enable = true;
      user   = "rcx";
      extraConfig = builtins.readFile ./greeter-mini.conf;
    };
  };
}
