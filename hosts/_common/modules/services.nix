{...}: {
  services.openssh.enable = true;
  services.dbus.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    extraConfig.pipewire."92-low-latency" = {
      "context.properties" = [
        {
          name = "libpipewire-module-protocol-pulse";
          args = {};
        }
      ];
      "pulse.properties" = {
        "pulse.min.req" = "32/48000";
        "pulse.default.req" = "32/48000";
        "pulse.max.req" = "32/48000";
        "pulse.min.quantum" = "32/48000";
        "pulse.max.quantum" = "32/48000";
      };
      "stream.properties" = {
        "node.latency" = "32/48000";
        "resample.quality" = 1;
      };
    };

    wireplumber.extraConfig."99-disable-suspend" = {
      "monitor.alsa.rules" = [
        {
          matches = [
            {
              "node.name" = "~alsa_input.*";
            }
            {
              "node.name" = "~alsa_output.*";
            }
          ];
          actions = {
            update-props = {
              "session.suspend-timeout-seconds" = 0;
            };
          };
        }
      ];
    };
  };

  services.udisks2.enable = true;
  services.blueman.enable = true;
}
