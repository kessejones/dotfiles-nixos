{...}: {
  imports = [
    ./hardware.nix
    ./modules
    ../_common
  ];

  environment.etc."pipewire/pipewire.conf.d/roc-sink.conf".text = ''
     context.modules = [
      {   name = libpipewire-module-roc-sink
          args = {
              fec.code = disable
              remote.ip = 192.168.0.222
              remote.source.port = 10001
              remote.repair.port = 10002
              sink.name = "ROC Sink"
              sink.props = {
                node.name = "roc-sink"
              }
          }
      }
    ]
  '';
}
