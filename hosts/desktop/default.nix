{...}: {
  imports = [
    ./hardware.nix
    ./modules
    ../_common
  ];

  environment.etc."pipewire/pipewire.conf.d/10-loopback-line_in.conf".text = ''
    context.modules = [
      {
        name = libpipewire-module-loopback
        args = {
          node.description = "Loopback Line-in"
          capture.props = {
            audio.position = [ FL FR ]
            node.target = "alsa_input.pci-0000_00_1f.3.analog-stereo"
          }
          playback.props = {
            audio.position = [ FL FR ]
            node.name = "Loopback-line_in"
            media.class = "Stream/Output/Audio"
          }
        }
      }
    ]
  '';

  environment.sessionVariables = rec {
    NIX_PROFILE_LIB = "$HOME/.nix-profile/lib";
    USER_LIB = "$HOME/.local/lib";
    LD_LIBRARY_PATH = [
      NIX_PROFILE_LIB
      USER_LIB
    ];
  };
}
