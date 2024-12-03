{pkgs, ...}: {
  programs.nixcord = {
    enable = true;
    discord.vencord.package = pkgs.vencord;
    config = {
      useQuickCss = true;
      themeLinks = [
        "https://raw.githubusercontent.com/catppuccin/discord/refs/heads/main/themes/mocha.theme.css"
      ];
      frameless = true;
      plugins = {
        hideAttachments.enable = true;
        ignoreActivities = {
          enable = true;
          ignorePlaying = true;
          ignoreWatching = true;
        };
      };
    };
  };
}
