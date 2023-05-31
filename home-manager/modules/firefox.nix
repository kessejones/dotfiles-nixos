{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    profiles.default = {
      isDefault = true;
      settings = {
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
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;

        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;

        # privacy
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
        "geo.enabled" = false;
        "dom.battery.enabled" = false;
        "network.IDN_show_punycode" = true;
        "plugins.enumerable_names" = "";
        "beacon.enabled" = false;
        "browser.send_pings" = false;
        "dom.webnotifications.enabled" = false;
        "toolkit.tabbox.switchByScrolling" = true;
        "browser.ctrlTab.recentlyUsedOrder" = false;
        "browser.search.hiddenOneOffs" = "";
        "browser.urlbar.suggest.searches" = false;
        "browser.toolbars.bookmarks.visibility" = "never";

        # search engine
        "browser.urlbar.placeholderName" = "DuckDuckGo";
        "browser.search.defaultEngine" = "DuckDuckGo";

        # homepage
        "browser.selfsupport.url" = "";
        "browser.aboutHomeSnippets.updateUrl" = "";
        "browser.startup.homepage_override.mstone" = "ignore";
        "browser.startup.homepage_override.buildId" = "";
        "browser.homepage_welcome_url" = "";
        "browser.homepage_welcome_url.additional" = "";
        "browser.homepage_override_url" = "";
      };
    };

    package = pkgs.wrapFirefox pkgs.firefox-esr-unwrapped {
      extraNativeMessagingHosts = with pkgs.nur.repos.wolfangaukang; [vdhcoapp];
    };
  };
}
