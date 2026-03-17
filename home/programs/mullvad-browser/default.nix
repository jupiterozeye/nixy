# Mullvad Browser — privacy-focused Firefox fork
# Configured to remember logins, history, forms, with vertical tabs and dark mode.
# Includes Bitwarden + Sidebery extensions pre-installed.
{pkgs, ...}: let
  bitwarden-xpi = pkgs.fetchurl {
    url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
    sha256 = "sha256-YUOvXWHZUCH83Wk5q4wY+VNfd1yA1LafddHSOPga40c=";
  };

  sidebery-xpi = pkgs.fetchurl {
    url = "https://addons.mozilla.org/firefox/downloads/latest/sidebery/latest.xpi";
    sha256 = "sha256-jVetNRd0QvaonD0xn6PgWGN2ofK3Lw/TAyOG5fNQXbg=";
  };

  mullvad-browser-base = pkgs.mullvad-browser.override {
    extraPrefs = ''
      // === Privacy overrides: remember data across sessions ===
      // Master switch — must be false or individual clearOnShutdown prefs are ignored
      lockPref("privacy.sanitize.sanitizeOnShutdown", false);
      // Disable always-private browsing
      lockPref("browser.privatebrowsing.autostart", false);
      // Remember logins
      lockPref("signon.rememberSignons", true);
      // Remember history
      lockPref("places.history.enabled", true);
      lockPref("privacy.clearOnShutdown.history", false);
      lockPref("privacy.clearOnShutdown_v2.historyFormDataAndDownloads", false);
      // Remember search and form fields
      lockPref("browser.formfill.enable", true);
      lockPref("privacy.clearOnShutdown.formdata", false);
      // Remember sessions/cookies
      lockPref("privacy.clearOnShutdown.cookies", false);
      lockPref("privacy.clearOnShutdown.sessions", false);
      lockPref("privacy.clearOnShutdown_v2.cookiesAndStorage", false);
      // Dark mode
      lockPref("ui.systemUsesDarkTheme", 1);
      lockPref("browser.theme.content-theme", 0);
      // Sidebar — native vertical tabs (Firefox 131+, may not apply to all MB versions)
      lockPref("sidebar.verticalTabs", true);
      lockPref("sidebar.expandOnHover", true);
      lockPref("sidebar.revamp", true);
      // Search suggestions
      lockPref("browser.search.suggest.enabled", true);
    '';
  };

  # Wrap to include Bitwarden + Sidebery extensions
  mullvad-browser = pkgs.symlinkJoin {
    name = "mullvad-browser";
    paths = [mullvad-browser-base];
    postBuild = ''
      rm -rf $out/share/mullvad-browser/distribution/extensions
      mkdir -p $out/share/mullvad-browser/distribution/extensions
      for ext in ${mullvad-browser-base}/share/mullvad-browser/distribution/extensions/*; do
        ln -s "$ext" $out/share/mullvad-browser/distribution/extensions/
      done
      ln -s ${bitwarden-xpi} "$out/share/mullvad-browser/distribution/extensions/{446900e4-71c2-419f-a6a7-df9c091e268b}.xpi"
      ln -s ${sidebery-xpi} "$out/share/mullvad-browser/distribution/extensions/{3c078156-979c-498b-8990-85f7987571a7}.xpi"
    '';
  };
in {
  home.packages = [mullvad-browser];

  home.sessionVariables = {
    DEFAULT_BROWSER = "${mullvad-browser}/bin/mullvad-browser";
  };
}
