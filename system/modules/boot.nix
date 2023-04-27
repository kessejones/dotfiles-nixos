{pkgs, ...}: {
  boot.kernelPackages = pkgs.linuxPackages_6_2;
  boot.loader = {
    efi = {
      efiSysMountPoint = "/boot";
    };

    grub = {
      enable = true;
      version = 2;
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      gfxmodeEfi = "1920x1080";
      theme = pkgs.catppuccin.grub-mocha;
    };
  };
}