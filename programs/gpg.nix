{ inputs, lib, config, pkgs, ... }: {
  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;

    enableBashIntegration = true;
    enableSshSupport      = true;

    pinentryFlavor = "tty";

    # Keygrip of main GPG key
    sshKeys = [ "E7712E4A5DB55C50E34C5EA11C8D23AB7D7F53B5" ];
  };
}
