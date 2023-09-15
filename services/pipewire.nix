{ inputs, lib, config, pkgs, ... }: {
  services.pipewire = {
    enable = true;

    audio = {
      enable = true;
    };

    alsa = {
      enable       = true;
      support32Bit = true;
    };

    pulse = {
      enable = true;
    };
  };
}
