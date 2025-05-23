{...}: {
  services.openssh.enable = true;
  services.dbus.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.udisks2.enable = true;
  services.blueman.enable = true;
}
