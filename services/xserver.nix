{ inputs, lib, config, pkgs, ...}: {
  imports = [
    ./xmonad/xmonad.nix
    ./lightdm.nix
  ];

  services.xserver = {
    enable = true;

    videoDrivers = [ "nvidia" ];

    libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
      };
    };
  };
}
