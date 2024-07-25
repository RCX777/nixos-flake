{ ... }: {
  programs.ssh = {
    enable = true;

    # This is used to avoid a bug when using GPG keys as SSH
    # TODO: research this option sometimes in the future
    extraConfig = ''
      Match host * exec "gpg-connect-agent UPDATESTARTUPTTY /bye"
    '';
  };
}
