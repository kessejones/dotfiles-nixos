{pkgs, ...}: {
  programs.nnn = {
    enable = true;

    bookmarks = {
      d = "~/Documents";
      D = "~/Downloads";
      S = "~/src";
    };

    plugins.mappings = {
      c = "fzcd";
      f = "finder";
      v = "imgview";
    };
  };
}
