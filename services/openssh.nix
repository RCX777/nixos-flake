{ inputs, lib, config, pkgs, ... }: {
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
    settings.PasswordAuthentication = false;
  };
}
