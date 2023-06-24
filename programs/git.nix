{ inputs, lib, config, pkgs, ... }: {
  programs.git = {
    enable = true;

    signing = {
      signByDefault = true;

      # Fingerprint of key exposed by gpg-agent (see gpg.nix)
      key = "30E2A48ACC58C42F";
    };

    userName  = "RCX777";
    userEmail = "robertcnst02@gmail.com";
  };
}
