{
  pkgs,
  unstable-pkgs,
  ...
}: {
  environment.systemPackages = with pkgs;
    [
      vim
      wget
      git
      curl
      cryptsetup
      alsa-utils
      gparted

      sshfs

      wally-cli

      fish
    ]
    ++ [
      unstable-pkgs.nushell
    ];
}
