{...}: {
  programs.librewolf = {
    enable = true;

    settings = {
      "browser.uiCustomization.state" = "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[],\"nav-bar\":[\"back-button\",\"forward-button\",\"stop-reload-button\",\"customizableui-special-spring1\",\"urlbar-container\",\"customizableui-special-spring2\",\"save-to-pocket-button\",\"downloads-button\",\"fxa-toolbar-menu-button\",\"unified-extensions-button\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"firefox-view-button\",\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"vertical-tabs\":[],\"PersonalToolbar\":[\"import-button\",\"personal-bookmarks\"]},\"seen\":[\"save-to-pocket-button\",\"developer-button\"],\"dirtyAreaCache\":[\"nav-bar\",\"vertical-tabs\",\"PersonalToolbar\"],\"currentVersion\":20,\"newElementCount\":2}";

      # disable experiments
      "experiments.activeExperiment" = false;
      "experiments.enabled" = false;
      "experiments.supported" = false;
      "extensions.pocket.enabled" = false;
      "middlemouse.paste" = false;
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      "devtools.theme" = "dark";
      "browser.zoom.siteSpecific" = false;

      "browser.urlbar.suggest.quicksuggest.sponsored" = false;
      "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
      "services.sync.prefs.sync.browser.newtabpage.pinned" = false;

      "browser.newtabpage.activity-stream.telemetry" = false;
      "browser.newtabpage.activity-stream.feeds.telemetry" = false;
      "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
      "browser.newtabpage.activity-stream.showSponsored" = false;
      "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;
      "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.havePinned" = "duckduckgo";
      "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.searchEngines" = "duckduckgo";

      # privacy
      "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = false;
      "privacy.clearOnShutdown_v2.cache" = false;
      "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
      "browser.contentblocking.category" = "strict";
      "privacy.donottrackheader.enabled" = true;
      "privacy.donottrackheader.value" = 1;
      "privacy.firstparty.isolate" = true;
      "privacy.trackingprotection.enabled" = true;
      "privacy.trackingprotection.socialtracking.enabled" = true;
      "privacy.trackingprotection.cryptomining.enabled" = true;
      "privacy.trackingprotection.figerprinting.enabled" = true;
      "toolkit.telemetry.enabled" = false;
      "toolkit.telemetry.unified" = false;
      "toolkit.telemetry.archive.enabled" = false;
      "toolkit.telemetry.shutdownPingSender.enabled" = false;
      "toolkit.telemetry.newProfilePing.enabled" = false;
      "toolkit.telemetry.server" = "";
      "geo.enabled" = false;
      "geo.wifi.logging.enable" = false;
      "geo.wifi.uri" = "";
      "dom.battery.enabled" = false;
      "dom.push.connection.enabled" = false;
      "dom.push.enabled" = false;
      "network.IDN_show_punycode" = true;
      "plugins.enumerable_names" = "";
      "beacon.enabled" = false;
      "browser.send_pings" = false;
      "dom.webnotifications.enabled" = false;
      "browser.ctrlTab.recentlyUsedOrder" = false;
      "browser.search.hiddenOneOffs" = "";
      "browser.urlbar.suggest.searches" = false;
      "browser.toolbars.bookmarks.visibility" = "never";
      "browser.ping-centre.telemetry" = false;
      "browser.newtabpage.activity-stream.telemetry.structuredIngestion.endpoint" = "";

      # search engine
      "browser.urlbar.placeholderName" = "DuckDuckGo";
      "browser.search.defaultEngine" = "DuckDuckGo";

      "privacy.clearOnShutdown.downloads" = false;
      "privacy.clearOnShutdown.history" = false;

      # homepage
      "browser.selfsupport.url" = "";
      "browser.aboutHomeSnippets.updateUrl" = "";
      "browser.startup.homepage_override.mstone" = "ignore";
      "browser.startup.homepage_override.buildId" = "";
      "browser.homepage_welcome_url" = "";
      "browser.homepage_welcome_url.additional" = "";
      "browser.homepage_override_url" = "";

      "browser.newtabpage.pinned" = builtins.toJSON [
        {
          label = "Youtube";
          url = "https://youtube.com";
        }
        {
          label = "Twitch";
          url = "https://twitch.tv";
        }
        {
          label = "Reddit";
          url = "https://reddit.com";
        }
        {
          label = "WhatsApp";
          url = "https://web.whatsapp.com";
        }
        {
          label = "Outlook";
          url = "https://outlook.live.com";
        }
        {
          label = "Github";
          url = "https://github.com";
        }
        {
          label = "Sourcegraph";
          url = "https://sourcegraph.com";
        }
      ];
    };
  };
}
