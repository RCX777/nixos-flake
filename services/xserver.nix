{ inputs, lib, config, pkgs, ...}: {
  services.xserver = {
    enable = true;

    videoDrivers = [ "nvidia" ];

    libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
      };
    };

    displayManager.lightdm = {
      greeters.mini = {
        enable = true;
        user   = "rcx";
        extraConfig = ''
          [greeter]
	  show-password-label = false
	  [greeter-theme]
	  font = "Overpass SemiBold"
	  font-size = 12px
	  text-color = "#cdd6f4"
	  background-color = "#11111b"
	  window-color = "#1e1e2e"
	  border-color = "#b4befe"
	  border-width = 2px
	  layout-space = 15
	  password-color = "#b4befe"
	  password-background-color = "#45475A"
	  passowrd-border-width = 0
	  background-image = ""
        '';
      };
      # Currently commented out, as it breaks lutris
      # See https://github.com/NixOS/nixpkgs/issues/239054
#      extraConfig = ''
#        user-authority-in-system-dir = true
#      '';
    };

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };
  };
}
