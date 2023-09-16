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

      corner-radius = 12.0;
      round-borders = 1;

      rounded-corners-exclude = [

      ];
    };

    backend = "glx";
  };
}
