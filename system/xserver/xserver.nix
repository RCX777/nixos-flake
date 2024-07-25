{ ... }: {
  imports = [
    ./xmonad/xmonad.nix
    ./picom.nix
  ];

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];

    extraConfig = ''
      Section "Monitor"
        Identifier "DP-0"
        Option "Primary" "true"

        ModeLine "2560x1440_240" 1056.75  2560 2608 2640 2720  1440 1443 1448 1619 +hsync -vsync
        Option "PreferredMode" "2560x1440_240"
        Option "UseEDID" "false"
        Option "UseEDIDFreqs" "false"

        Option "DPMS" "false"
      EndSection

      Section "Monitor"
        Identifier "HDMI-0"
        Option "RightOf" "DP-0"

        ModeLine "1920x1080_165" 387.81  1920 1968 2000 2080  1080 1083 1093 1130 +hsync -vsync
        Option "PreferredMode" "1920x1080_165"
        Option "UseEDID" "false"
        Option "UseEDIDFreqs" "false"

        Option "DPMS" "false"
      EndSection
    '';
    exportConfiguration = true;
  };
}

