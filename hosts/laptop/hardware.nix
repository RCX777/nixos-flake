{ config, lib, pkgs, modulesPath, ... }: {
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    initrd = {
      availableKernelModules = [ "xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ ];
    };

    kernelModules = [
      "kvm-intel"

      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];

    extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];

    kernelParams = [ "nosgx" ];

    extraModprobeConfig = ''
      options nvidia-drm modeset=1
      options snd_hda_intel model=asus-zenbook
      blacklist i2c_nvidia_gpu
    '';

    loader.systemd-boot.enable = lib.mkForce false;

    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot/";
    };
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  fileSystems."/" =
    { device = "/dev/disk/by-label/NIXROOT";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
    };

  swapDevices = [ ];

  hardware = {
    enableAllFirmware = true;
    cpu.intel = {
      updateMicrocode = true;
    };

    graphics = {
      enable = true;
      driSupport32Bit = true;
    };

    nvidia = {
      open = false;

      package = config.boot.kernelPackages.nvidiaPackages.beta;

      modesetting.enable = true;

      prime = {
        sync.enable = true;
        nvidiaBusId = "PCI:1:0:0";
        intelBusId  = "PCI:0:2:0";
      };
    };
  };

  powerManagement = {
    enable          = true;
    cpuFreqGovernor = "ondemand";
  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno2.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}

