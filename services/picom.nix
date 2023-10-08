{ inputs, lib, config, pkgs, ... }: {
  services.picom = {
    enable = true;

    settings = {
      # General
      vsync = false;

      use-ewmh-active-win = true; # ewmh is active in xmonad.hs
      no-ewmh-fullscreen  = true;

      unredir-if-possible = true;

      # Blur
      blur = {
        method     = "dual_kawase";
        background = true;
        strength   = 8;
      };

      # Transparency & Opacity

      # Shadows
      # shadow = true;
      shadow-radius   = 7.5;
      shadow-opacity  = 0.68;
      shadow-offset-x = -9;
      shadow-offset-y = -9;
      shadow-color    = "#010109";

      # Fading
      fading = true;
      fade-delta = 5;

      # Borders
      corner-radius = 12.0;
      round-borders = 1;

      # Window rules
      wintypes = {
        desktop = { shadow = true; };
        tooltip = { opacity = 0.8; };
      };

      # Excluding games from compositing
      rounded-corners-exclude = [
        "class_g = 'cs2'"
      ];
      blur-background-exclude = [
        "class_g = 'cs2'"
      ];
    };

    backend = "glx";
  };
}
