{ pkgs, ... }:

{

  environment.systemPackages = [
    (pkgs.writeScriptBin "chromium" "${pkgs.chromium}/bin/chromium --wm-window-animations-disabled --animation-duration-scale=0")
  ];

  programs.chromium = {
    enable = true;
    homepageLocation = "http://localhost";

    # https://chromeenterprise.google/policies/
    extraOpts = {
      BuiltInDnsClientEnabled = false;
      SearchSuggestEnabled = false;
      NewTabPageLocation = "chrome://version";
      CloudPrintSubmitEnabled = false;
      EnableMediaRouter = false;
      HideWebStoreIcon = true;
      MetricsReportingEnabled = false;
      RestoreOnStartup = 1;
      SpellcheckEnabled = true;
      SpellcheckLanguage = [ "en-US" ];
      WelcomePageOnOSUpgradeEnabled = false;
      BrowserSignin = 0;
      PasswordManagerEnabled = false;
      SyncDisabled = true;
      DefaultBrowserSettingEnabled = false;
      DefaultSearchProviderEnabled = true;
      DefaultSearchProviderSearchURL = "https://duckduckgo.com/?q={searchTerms}";
      ShowAppsShortcutInBookmarkBar = false;
      BookmarkBarEnabled = false;
    };

    extensions = [
      # KeePassXC-Browser
      "oboonakemofpalcgghocfoadofidjkkk"

      # Page load time
      "fploionmjgeclbkemipmkogoaohcdbig"

      # EditThisCookie
      "fngmhnnpilhplaeedifhccceomclgfbg"

      # Tab Counter
      "feeoiklfggbaibpdhkkngbpkppdmcjal"

      # uBlock Origin
      "cjpalhdlnbpafiamejdnhcphjbkeiagm"

      # Bypass Paywalls
      "dcpihecpambacapedldabdbpakmachpb;https://raw.githubusercontent.com/iamadamdev/bypass-paywalls-chrome/master/src/updates/updates.xml"
    ];
  };

}
