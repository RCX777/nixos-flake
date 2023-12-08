{ inputs, lib, config, pkgs, ... }: {
  
  # TODO: for some reason lightdm is not working properly on pc
  #       using sddm is a workaround! fix in the future!
  services.xserver.displayManager.sddm.enable = false;
  services.xserver.displayManager.lightdm.greeters.mini.enable = true;

  # TODO: re-add battery widget to bar.yuck
}
