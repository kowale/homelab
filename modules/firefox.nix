{ pkgs, ... }:

# https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265
# https://vermaden.wordpress.com/2024/03/18/sensible-firefox-setup/
# https://unixdigest.com/articles/choose-your-browser-carefully.html
# https://gitlab.com/engmark/root/-/blob/1341a7a0edd436a2c6901ea1ffc70213f9852bc6/configuration.nix#L393-538
# https://lobste.rs/s/0hcqj6/sensible_firefox_setup

{

  environment.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
  };

  # about:about
  programs.firefox = {
    enable = true;
    languagePacks = [ "en-US" ];

    # HM :(
    # For now move manually to .mozilla/firefox/7y2r4ss.default/chrome/userChrome.css
    #profiles.default = {
    #  name = "Default";
    #  userChrome = ''
    #    .titlebar-buttonbox-container{ display:none }
    #    .titlebar-spacer[type="post-tabs"]{ display:none }
    #    .titlebar-spacer {
    #        display: none !important;
    #    }
    #    #TabsToolbar {
    #        padding-inline-start: initial !important;
    #    }
    #    .tabbrowser-tabs:not([movingtab]) .tabbrowser-tab[first-visible-tab] .tab-background,
    #    .tabbrowser-tabs[movingtab] .tabbrowser-tab[first-visible-tab][style*="translateX(0px)"] .tab-background {
    #        border-inline-start: initial !important;
    #    }
    #    .tab-line { display: none !important; }
    #  '';
    #};

    # about:policies
    policies = {
      OfferToSaveLogins = false;
      DisableTelemetry = true;
      DisableAppUpdate = true;
      DisableFirefoxStudies = true;
      DisableFirefoxAccounts = true;
      DisablePocket = true;
      DNSOverHTTPS = false;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DisableFirefoxScreenshots = true;
      DisableAccounts = true;
      DontCheckDefaultBrowser = true;
      DisplayMenuBar = "never";
      DisplayBookmarksToolbar = "never";
      SearchBar = "unified";
      ShowHomeButton = false;
      NoDefaultBookmarks = true;
      Homepage = "https://kszk.eu";
      LegacyProfiles = false;

      # about:config
      # about:preferences
      Preferences = {
        "browser.gesture.swipe.left" = "";
        "browser.gesture.swipe.right" = "";
        "browser.startup.homepage" = "about:newtab";
        "browser.download.dir" = "/home/kon/other/downloads";
        "browser.theme.content-theme" = 0;
        "browser.theme.toolbar-theme" = 0;
        "browser.firefox-view.view-count" = 2;
        "browser.firefox-view" = false;
        "browser.uidensity" = 1;
        "ui.prefersReducedMotion" = 1;
        "identity.fxaccounts.enabled" = 0;
        "extensions.pocket.enabled" = 0;
        "ui.key.menuAccessKeyFocuses" = 0;
        "accessibility.typeaheadfind.flashBar" = 0;
        "browser.contentblocking.category" = "strict";
        "browser.laterrun.enabled" = false;
        "browser.messaging-system.whatsNewPanel.enabled" = false;
        "browser.newtabpage.enabled" = false;
        "browser.protections_panel.infoMessage.seen" = true;
        "browser.rights.3.shown" = true;
        "browser.search.suggest.enabled" = false;
        "browser.startup.page" = 3; # tab
        "browser.toolbars.bookmarks.visibility" = "never";
        # "browser.tabs.firefox-view.mobilePromo.dismissed" = true;
        "browser.urlbar.quicksuggest.scenario" = "history";
        "browser.urlbar.suggest.engines" = false;
        "browser.urlbar.suggest.searches" = false;
        # "browser.warnOnQuitShortcut" = false;
        # "datareporting.policy.dataSubmissionPolicyAcceptedVersion" = 2;
        "devtools.everOpened" = true;
        # "devtools.performance.new-panel-onboarding" = false;
        # "distribution.iniFile.exists.value" = true;
        # "doh-rollout.doneFirstRun" = true;
        "extensions.recommendations.hideNotice" = true;
        "extensions.ui.dictionary.hidden" = false;
        "extensions.ui.locale.hidden" = false;
        "extensions.ui.plugin.hidden" = false;
        "extensions.ui.sitepermission.hidden" = false;
        "findbar.highlightAll" = true;
        # "general.smoothScroll" = false;
        # "identity.fxaccounts.toolbar.accessed" = true;
        # "intl.regional_prefs.use_os_locales" = true;
        # "pref.downloads.disable_button.edit_actions" = false;
        # "pref.privacy.disable_button.cookie_exceptions" = false;
        # "privacy.annotate_channels.strict_list.enabled" = true;
        # "privacy.donottrackheader.enabled" = true;
        # "privacy.fingerprintingProtection" = true;
        # "privacy.partition.network_state.ocsp_cache" = true;
        # "privacy.popups.showBrowserMessage" = false;
        # "privacy.query_stripping.enabled" = true;
        # "privacy.query_stripping.enabled.pbmode" = true;
        "privacy.resistFingerprinting" = true;
        "privacy.trackingprotection.emailtracking.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.userContext.enabled" = true;
        "services.sync.declinedEngines" = "passwords";
        "services.sync.engine.passwords" = false;
        # "signon.rememberSignons" = false;
        # "toolkit.telemetry.pioneer-new-studies-available" = false;
        # "toolkit.telemetry.reportingpolicy.firstRun" = false;
        # "trailhead.firstrun.didSeeAboutWelcome" = true;
        # "widget.gtk.overlay-scrollbars.enabled" = false;
        # "browser.cache.memory.enable" = false;
        "browser.compactmode.show" = true;
        # "browser.display.show_image_placeholders" = false;
        "browser.download.alwaysOpenPanel" = false;
        "browser.download.autohideButton" = false;
        "browser.download.improvements_to_download_panel" = false;
        "browser.download.saveLinkAsFilenameTimeout" = 0;
        # "browser.link.open_newwindow.restriction" = 0;
        # "browser.link.open_newwindow" = 3;
        "browser.search.openintab" = true;
        "browser.tabs.animate" = false;
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        "browser.tabs.insertRelatedAfterCurrent" = true;
        "browser.tabs.tabMinWidth" = 20;
        # "browser.tabs.loadBookmarksInTabs" = true;
        # "dom.block_download_insecure" = false;
        # "dom.event.contextmenu.enabled" = false;
        # "dom.media.autoplay-policy-detection.enabled" = false;
        # "dom.webnotifications.enabled" = false;
        # "general.smoothScroll.lines" = false;
        # "general.smoothScroll.mouseWheel" = false;
        # "general.smoothScroll.other" = false;
        # "general.smoothScroll.pages" = false;
        # "general.smoothScroll.pixels" = false;
        # "general.smoothScroll.scrollbars" = false;
        "geo.enabled" = false;
        "general.autoScroll" = true;
        "general.useragent.locale" = "en-US";
        "browser.urlbar.quickactions.enabled" = false;
        "browser.urlbar.quickactions.showPrefs" = false;
        "browser.urlbar.shortcuts.quickactions" = false;
        "browser.urlbar.suggest.quickactions" = false;
        # "gfx.xrender.enabled" = true;
        # "image.jxl.enabled" = true;
        # "loop.enabled" = false;
        # "media.autoplay.allow-extension-background-pages" = false;
        # "media.autoplay.default" = 5;
        # "media.eutoplay.enabled" = false;
        # "media.block-autoplay-until-in-foreground" = false;
        # "media.ffmpeg.vaapi.enabled" = true;
        # "media.peerconnection.enabled" = false;
        # "media.webrtc.hw.h264.enabled" = false;
        # "network.http.http3.enabled" = false;
        # "network.prefetch-next" = false;
        # "network.trr.mode" = 5;
        # "pdfjs.defaultZoomValue" = "page-fit";
        "browser.urlbar.suggest.calculator" = true;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.tabs.loadInBackground" = true;
        "privacy.firstparty.isolate" = true;
        "privacy.firstparty.isolate.block_post_message" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.tabs.drawInTitlebar" = true;
        "svg.context-properties.content.enabled" = true;
        # "security.dialog_enable_delay" = 0;
        # "security.notification_enable_delay" = 0;
        # "security.ssl3.rsa_fips_des_ede3_sha" = false;
        # "security.tls.version.fallback-limit" = 0;
        # "security.tls.version.max" = 4;
        # "security.tls.version.min" = 0;
        # "toolkit.scrollbox.smoothScroll" = false;
        # "browser.safebrowsing.downloads.enabled" = false;
        # "browser.safebrowsing.downloads.remote.url" = "127.0.0.1";
        # "browser.safebrowsing.enabled" = false;
        # "browser.safebrowsing.malware.enabled" = false;
        # "browser.safebrowsing.provider.google.advisoryURL" = "127.0.0.1";
        # "browser.safebrowsing.provider.google.gethashURL" = "127.0.0.1";
        # "browser.safebrowsing.provider.google.reportMalwareMistakeURL" = "127.0.0.1";
        # "browser.safebrowsing.provider.google.reportPhishMistakeURL" = "127.0.0.1";
        # "browser.safebrowsing.provider.google.reportURL" = "127.0.0.1";
        # "browser.safebrowsing.provider.google.updateURL" = "127.0.0.1";
        # "browser.safebrowsing.provider.google4.advisoryURL" = "127.0.0.1";
        # "browser.safebrowsing.provider.google4.dataSharingURL" = "127.0.0.1";
        # "browser.safebrowsing.provider.google4.gethashURL" = "127.0.0.1";
        # "browser.safebrowsing.provider.google4.reportMalwareMistakeURL" = "127.0.0.1";
        # "browser.safebrowsing.provider.google4.reportPhishMistakeURL" = "127.0.0.1";
        # "browser.safebrowsing.provider.google4.reportURL" = "127.0.0.1";
        # "browser.safebrowsing.provider.google4.updateURL" = "127.0.0.1";
        # "browser.safebrowsing.provider.mozilla.gethashURL" = "127.0.0.1";
        # "browser.safebrowsing.provider.mozilla.updateURL" = "127.0.0.1";
        # "browser.safebrowsing.reportMalwareMistakeURL" = "127.0.0.1";
        # "browser.safebrowsing.reportPhishMistakeURL" = "127.0.0.1";
        # "browser.safebrowsing.reportPhishURL" = "127.0.0.1";
        # "browser.safebrowsing.reportURL" = "127.0.0.1";
        # "browser.safebrowsing.updateURL" = "127.0.0.1";
        # "captivedetect.canonicalContent" = "127.0.0.1";
        # "captivedetect.canonicalURL" = "127.0.0.1";
        "toolkit.telemetry.enabled" = false;
        "browser.uitour.enabled" = false;
        "captivedetect.maxRetryCount" = 0;
        "captivedetect.maxWaitingTime" = 0;
        "captivedetect.pollingTime" = 0;
        # "datareporting.healthreport.about.reportUrl" = "127.0.0.1";
        # "datareporting.healthreport.infoURL" = "127.0.0.1";
        # "datareporting.healthreport.service.enabled" = false;
        # "datareporting.healthreport.uploadEnabled" = false;
        "gfx.webrender.all" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "widget.dmabuf.force-enabled" = true;
      };

      # about:addons
      # about:debugging#/runtime/this-firefox
      ExtensionSettings = {

        "*".installation_mode = "blocked";

        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "keepassxc-browser@keepassxc.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
          installation_mode = "force_installed";
        };

        "gdpr@cavi.au.dk" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/consent-o-matic/latest.xpi";
          installation_mode = "force_installed";
        };

        "firefox-compact-dark@mozilla.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/dark/latest.xpi";
          installation_mode = "force_installed";
        };

        "{d634138d-c276-4fc8-924b-40a0ea21d284}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/1password-x-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };

        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
          installation_mode = "force_installed";
        };

        "bypasspaywalls@bypasspaywalls" = {
          install_url = "https://github.com/iamadamdev/bypass-paywalls-chrome/releases/latest/download/bypass-paywalls-firefox.xpi";
          installation_mode = "force_installed";
        };

      };

      Handlers = {
        # mimeTypes."application/pdf".action = "saveToDisk";
        schemes.mailto.handlers = [ null ];
      };

      SearchEngines = {
        PreventInstalls = true;
        Default = "DuckDuckGo";
        Remove = [ "Amazon.com" "Bing" "Google" "Wikipedia (en)"];
      };

      UserMessaging = {
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        MoreFromMozilla = false;
        SkipOnboarding = true;
        UrlbarInterventions = false;
        WhatsNew = false;
        Locked = true;
      };

    };
  };

}
