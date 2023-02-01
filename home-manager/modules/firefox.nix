{pkgs}: {
  programs.firefox = {
    enable = true;
    profiles.default.search = {
      default = "DuckDuckGo";
    };
  };
}
