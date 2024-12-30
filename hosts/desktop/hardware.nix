{
  lib,
  config,
  ...
}: {
  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod"];
  boot.kernelModules = ["kvm-intel" "iwlwifi"];
  boot.supportedFilesystems = lib.mkForce ["btrfs" "reiserfs" "vfat" "f2fs" "xfs" "ntfs" "cifs" "ext4"];
  boot.blacklistedKernelModules = [];

  hardware = {
    graphics.enable = true;
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    bluetooth.settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };

    nvidia = {
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/BOOT";
    fsType = "vfat";
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS";
    fsType = "ext4";
  };

  fileSystems."/media/Data" = {
    device = "/dev/disk/by-label/Data";
    fsType = "ntfs";
    options = ["rw" "uid=1000"];
  };

  swapDevices = [];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
