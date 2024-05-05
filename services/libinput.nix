{ ... }: {
  services.libinput = {
    enable = true;
    mouse = {
      accelProfile = "flat";
    };
  };
}

