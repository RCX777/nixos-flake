{ lib, ... }: {
  
  # TODO: for some reason lightdm is not working properly on pc
  #       using sddm is a workaround! fix in the future!
  services.displayManager.sddm.enable = lib.mkForce false;
  services.xserver.displayManager.lightdm.greeters.mini.enable = lib.mkForce true;

  # TODO: re-add battery widget to bar.yuck
}
