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
        config.lib.stylix.colors.base00; # Color of the text displayed on the wallpaper (Lockscreen, display manager, ...)
    };
    description = "Theme configuration options";
  };

  config.stylix = {
    enable = true;

    # See https://tinted-theming.github.io/tinted-gallery/ for more schemes
    base16Scheme = {
      base00 = "0b0e14"; # Default Background
      base01 = "131721"; # Lighter Background (Used for status bars, line number and folding marks)
      base02 = "202229"; # Selection Background
      base03 = "3e4b59"; # Comments, Invisibles, Line Highlighting
      base04 = "bfbdb6"; # Dark Foreground (Used for status bars)
      base05 = "e6e1cf"; # Default Foreground, Caret, Delimiters, Operators
      base06 = "ece8db"; # Light Foreground (Not often used)
      base07 = "f2f0e7"; # Light Background (Not often used)
      base08 = "f07178"; # Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
      base09 = "ff8f40"; # Integers, Boolean, Constants, XML Attributes, Markup Link Url
      base0A = "ffb454"; # Classes, Markup Bold, Search Text Background
      base0B = "aad94c"; # Strings, Inherited Class, Markup Code, Diff Inserted
      base0C = "95e6cb"; # Support, Regular Expressions, Escape Characters, Markup Quotes
      base0D = "59c2ff"; # Functions, Methods, Attribute IDs, Headings, Accent color
      base0E = "d2a6ff"; # Keywords, Storage, Selector, Markup Italic, Diff Changed
      base0F = "e6b450"; # Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
    };

    cursor = {
      name = "BreezeX-RosePine-Linux";
      package = pkgs.rose-pine-cursor;
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
      url = "https://raw.githubusercontent.com/anotherhadi/awesome-wallpapers/refs/heads/main/app/static/wallpapers/mosaic_dark.png";
      sha256 = "sha256-gLcCBLDxlQqB7AgOnhtPnRlGV+tfwBORZATNLcB7xSs=";
    };
  };
}
