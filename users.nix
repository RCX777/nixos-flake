{ inputs, lib, config, pkgs, ... }: {
  users.users = {
    rcx = {
      initialPassword = "youcantmilkthose";
      isNormalUser    = true;

      openssh.authorizedKeys.keys = [ ];

      extraGroups = [ "wheel" "networkmanager" ];
    };
  };
}
