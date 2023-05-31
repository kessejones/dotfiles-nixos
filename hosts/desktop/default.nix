{...}: {
  imports = [
    ./hardware.nix
    ./modules
    ../_common
  ];

  environment.etc."pipewire/pipewire.conf.d/60-roc-source.conf".text = ''
     context.modules = [
      {   name = libpipewire-module-roc-source
          args = {
              local.ip = 0.0.0.0
              resampler.profile = medium
              fec.code = disable
              sess.latency.msec = 5000
              local.source.port = 10001
              local.repair.port = 10002
              source.name = "ROC Source"
              source.props = {
                node.name = "roc-source"
                target.object = "combine-sink-stereo"
              }
          }
      }
    ]
  '';

  environment.etc."pipewire/pipewire.conf.d/50-combine-output-20.conf".text = ''
    context.modules = [
      {
        name = libpipewire-module-combine-stream
        args = {
          combine.mode = sink
          node.name = "combine-output-20"
          node.description = "Output Proxy 2.0"
          combine.latency-compensate = false   # if true, match latencies by adding delays
          combine.props = {
            audio.position = [ FL FR ]
          }
          stream.props = {
          }
          stream.rules = [
            {
              matches = [ { media.class = "Audio/Sink" } ]
              actions = { create-stream = { } }
            }
          ]
        }
      }
    ]
  '';
}
