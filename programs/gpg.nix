{ inputs, lib, config, pkgs, ... }: {
  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;

    enableBashIntegration = true;
    enableSshSupport      = true;

    # pinentryFlavor = "tty";
   };
}
