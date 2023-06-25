{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    curl
    cryptsetup
    alsa-utils

    sshfs

    wally-cli
  ];
}
