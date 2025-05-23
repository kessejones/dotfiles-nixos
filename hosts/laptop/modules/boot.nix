{pkgs, ...}: {
  boot.kernelPackages = pkgs.linuxPackages_6_12;
  boot.loader = {
    efi = {
      efiSysMountPoint = "/boot";
    };

    grub = {
      enable = true;
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      gfxmodeEfi = "1920x1080";
      catppuccin.enable = true;
    };
  };
}
