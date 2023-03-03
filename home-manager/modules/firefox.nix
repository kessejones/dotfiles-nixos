{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    profiles.default = {
      isDefault = true;
      search.default = "DuckDuckGo";
      settings = {
        "browser.ctrlTab.recentlyUsedOrder" = false;
        "browser.search.hiddenOneOffs" = "";
        "browser.urlbar.suggest.searches" = false;
        "experiments.activeExperiment" = false;
        "experiments.enabled" = false;
        "experiments.supported" = false;
        "extensions.pocket.enabled" = false;
        "middlemouse.paste" = false;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

        # Hardware acceleration related settings.
        "gfx.webrender.all" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.ffmpeg.vaapi-drm-display.enabled" = true;
      };
    };

    package = pkgs.wrapFirefox pkgs.firefox-esr-unwrapped {
      extraNativeMessagingHosts = with pkgs.nur.repos.wolfangaukang; [vdhcoapp];
      extraPolicies = {
        CaptivePortal = false;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DisableFirefoxAccounts = false;
        FirefoxHome = {
          Pocket = false;
          Snippets = false;
        };
        UserMessaging = {
          ExtensionRecomendations = false;
          SkipOnboarding = true;
        };
      };

      extraPrefs = ''
        lockPref("security.identityblock.show_extended_validation", true);
        lockPref("devtools.theme", "dark");
        lockPref("media.peerconnection.enabled", false);
        lockPref("geo.enabled", false);
        lockPref("dom.battery.enabled", false);
        lockPref("beacon.enabled", false);
        lockPref("dom.event.contextmenu.enabled", false);
        lockPref("network.IDN_show_punycode", false);
        lockPref("network.IDN_show_punycode", true);
        lockPref("browser.tabs.tabmanager.enabled", false);
      '';
    };
  };
}
