# Reminder: This is a module for nixos, not home-manager!

{ inputs, lib, config, pkgs, ... }: {
  programs.gnupg.agent = {
    enable            = true;
    enableSSHSupport  = true;
    enableExtraSocket = true;
  };
}
