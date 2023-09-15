{ inputs, lib, config, pkgs, ... }: {
  services.picom = {
    enable = true;

    settings = {
      blur = {
        method     = "gaussian";
        background = true;
        size       = 20;
        deviation  = 15.0;
      };

      corner.radius = 12;
    };

    backend = "glx";
  };
}
