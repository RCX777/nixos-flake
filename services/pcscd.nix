# Used for gpg-agent

{ inputs, lib, config, pkgs, ... }: {
  services.pcscd.enable = true;
}
