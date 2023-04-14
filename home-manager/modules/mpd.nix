{...}: {
  services.mpd = {
    enable = true;

    network = {
      startWhenNeeded = true;
      listenAddress = "127.0.0.1";
      port = 6600;
    };

    musicDirectory = "~/Music";

    extraConfig = ''
      audio_output {
        type "pipewire"
        name "PipeWire Sound Server"
      }

      audio_output {
        type            "fifo"
        name            "Visualizer"
        path            "/tmp/mpd.fifo"
        format          "44100:16:2"
      }
    '';
  };
}
