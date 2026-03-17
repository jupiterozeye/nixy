{
  lib,
  pkgs,
  config,
  ...
}: {
  options.theme = lib.mkOption {
    type = lib.types.attrs;
    default = {
      rounding = 30;
      gaps-in = 12;
      gaps-out = 12 * 2;
      active-opacity = 0.96;
      inactive-opacity = 0.94;
      blur = true;
      border-size = 4;
      animation-speed = "fast"; # "fast" | "medium" | "slow"
      fetch = "none"; # "nerdfetch" | "neofetch" | "pfetch" | "none"
      textColorOnWallpaper =
        config.lib.stylix.colors.base00;
    };
    description = "Theme configuration options";
  };

  config.stylix = {
    enable = true;

    # Everforest Dark Hard — https://github.com/sainnhe/everforest
    base16Scheme = {
      base00 = "272e33"; # Default Background (bg0)
      base01 = "2e383c"; # Lighter Background (bg1)
      base02 = "374145"; # Selection Background (bg2)
      base03 = "859289"; # Comments, Invisibles (grey1)
      base04 = "9da9a0"; # Dark Foreground — status bars (grey2)
      base05 = "d3c6aa"; # Default Foreground
      base06 = "e6e2cc"; # Light Foreground
      base07 = "fdf6e3"; # Lightest Foreground
      base08 = "e67e80"; # Variables, Diff Deleted (red)
      base09 = "e69875"; # Constants, Markup Link Url (orange)
      base0A = "dbbc7f"; # Classes, Search Background (yellow)
      base0B = "a7c080"; # Strings, Diff Inserted (green)
      base0C = "83c092"; # Regex, Escape Characters (aqua)
      base0D = "7fbbb3"; # Functions, Headings, Accent (blue)
      base0E = "d699b6"; # Keywords, Selectors (purple)
      base0F = "7a8478"; # Deprecated (grey0)
    };

    cursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 20;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrains Mono Nerd Font";
      };
      sansSerif = {
        package = pkgs.source-sans-pro;
        name = "Source Sans Pro";
      };
      serif = config.stylix.fonts.sansSerif;
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 13;
        desktop = 13;
        popups = 13;
        terminal = 13;
      };
    };

    polarity = "dark";
    image = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/anotherhadi/awesome-wallpapers/main/app/static/wallpapers/it-is-some-waves_dark.png";
      sha256 = "sha256-XTS8Xo+gkpaPSLIIoG/1Uc7pxFeXi4rKjLTzU2XWpcM=";
    };
  };
}
