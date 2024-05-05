{ ... }: {
  imports = [
    ./xmonad/xmonad.nix
    ./lightdm.nix
  ];

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };
}

