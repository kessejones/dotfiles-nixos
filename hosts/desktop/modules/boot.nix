{pkgs, ...}: {
  boot.kernelPackages = pkgs.linuxPackages_6_6;
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
    };
  };
  catppuccin.grub.enable = true;

  boot.binfmt.emulatedSystems = ["aarch64-linux"];
}
