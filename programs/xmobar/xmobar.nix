{ inputs, lib, config, pkgs, ... }: {
  programs.xmobar = {
    enable      = true;
    extraConfig = builtins.readFile ./.xmobarrc;
  };
}
