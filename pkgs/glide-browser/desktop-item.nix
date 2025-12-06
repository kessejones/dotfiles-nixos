{
  glide-browser-bin,
  makeDesktopItem,
}:
makeDesktopItem rec {
  name = "Glide Browser";
  desktopName = name;
  exec = "${glide-browser-bin}/bin/glide-browser";
}
