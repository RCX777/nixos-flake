{ inputs, lib, config, pkgs, ... }: {
  services.picom = {
    enable = true;

    settings = {
      vsync = false;

      # Use ewmh (also active in xmonad.hs)
      use-ewmh-active-win = true;
      no-ewmh-fullscreen  = false;

      # Disable compositing when 'true' fullscreen windows are present
      # (works on games like a charm)
      unredir-if-possible = true;

      # Should improve performance (so far no visual artifacts encountered)
      glx-no-stencil      = true;

      # Blur
      blur = {
        method     = "dual_kawase";
        background = true;
        strength   = 8;
      };
       
      # Fading
      fading = true;
      fade-delta = 5;

      # Borders
      # corner-radius = 12.0;
      # round-borders = 1;

      # Specific window rules
      wintypes = {
        tooltip = { opacity = 0.8; };
      };
    };
 
    backend = "glx";
  };
}
