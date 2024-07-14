{ pkgs, ... }: {
  # Enable the default shell
  programs.zsh.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;

    users = {
      rcx = {
        initialPassword = "youcantmilkthose";
        isNormalUser    = true;

        openssh.authorizedKeys.keys = [ ];

        extraGroups = [
          "wheel"
          "networkmanager"
          "vboxusers"
          "dialout"
          "libvirtd"
        ];
      };
    };
  };
}
