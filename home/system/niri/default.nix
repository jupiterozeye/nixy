# Niri is a scrollable-tiling Wayland compositor.
{
  pkgs,
  config,
  lib,
  ...
}: let
  border-size = config.theme.border-size;
  gaps = config.theme.gaps-out;
  active-opacity = config.theme.active-opacity;
  inactive-opacity = config.theme.inactive-opacity;
  keyboardLayout = config.var.keyboardLayout;
in {
  home.packages = with pkgs; [
    qt5.qtwayland
    qt6.qtwayland
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    adw-gtk3
    grim
    slurp
    wl-clipboard
    brightnessctl
    playerctl
    gnome-themes-extra
    libva
    dconf
    wayland-utils
    wayland-protocols
    glib
    direnv
    fuzzel
    swaylock
    wlogout
    swaybg
  ];

  programs.niri.settings = {
    input.keyboard.xkb = {
      layout = keyboardLayout;
      options = "caps:escape";
    };

    input.touchpad = {
      tap = true;
      natural-scroll = true;
      click-method = "clickfinger";
    };

    prefer-no-csd = true;

    layout = {
      gaps = gaps;
      center-focused-column = "never";

      focus-ring.width = border-size;
      border.width = border-size;
    };

    # TODO: Blur config requires raw KDL (programs.niri.config) since the
    # niri-flake schema doesn't support WIP branch blur options yet.
    # For now, just set opacity via window-rules.
    window-rules = [
      {
        matches = [{is-active = true;}];
        opacity = active-opacity;
      }
      {
        matches = [{is-active = false;}];
        opacity = inactive-opacity;
      }
    ];

    spawn-at-startup = [
      {command = ["dbus-update-activation-environment" "--systemd" "--all"];}
      {command = ["lxqt-policykit-agent"];}
    ];

    binds = with config.lib.niri.actions; {
      # Help
      "Mod+Shift+Slash".action = show-hotkey-overlay;

      # Application launching
      "Mod+Return".action = spawn "ghostty";
      "Mod+Space".action = spawn "fuzzel";
      "Super+Alt+L".action = spawn "swaylock";
      "Mod+B".action = spawn "mullvad-browser";
      "Mod+E".action = spawn "thunar";
      "Mod+P".action = spawn "bitwarden";
      "Mod+T".action = toggle-window-floating;
      "Mod+X".action = spawn "wlogout";
      "Mod+N".action = spawn "noctalia" "sidebar" "toggle";

      # Window management
      "Mod+Q".action = close-window;

      # Focus within workspace (HJKL = vim nav)
      "Mod+H".action = focus-column-left;
      "Mod+L".action = focus-column-right;
      "Mod+J".action = focus-window-down;
      "Mod+K".action = focus-window-up;

      # Move columns/windows within workspace (Ctrl+HJKL)
      "Mod+Ctrl+H".action = move-column-left;
      "Mod+Ctrl+L".action = move-column-right;
      "Mod+Ctrl+J".action = move-window-down;
      "Mod+Ctrl+K".action = move-window-up;

      # Focus monitor (Arrow keys + Shift+HJKL)
      "Mod+Left".action = focus-monitor-left;
      "Mod+Right".action = focus-monitor-right;
      "Mod+Up".action = focus-monitor-up;
      "Mod+Down".action = focus-monitor-down;
      "Mod+Shift+H".action = focus-monitor-left;
      "Mod+Shift+L".action = focus-monitor-right;
      "Mod+Shift+J".action = focus-monitor-down;
      "Mod+Shift+K".action = focus-monitor-up;

      # Move column to monitor (Shift+Arrow + Ctrl+Shift+HJKL)
      "Mod+Shift+Left".action = move-column-to-monitor-left;
      "Mod+Shift+Right".action = move-column-to-monitor-right;
      "Mod+Shift+Up".action = move-column-to-monitor-up;
      "Mod+Shift+Down".action = move-column-to-monitor-down;
      "Mod+Ctrl+Shift+H".action = move-column-to-monitor-left;
      "Mod+Ctrl+Shift+L".action = move-column-to-monitor-right;
      "Mod+Ctrl+Shift+J".action = move-column-to-monitor-down;
      "Mod+Ctrl+Shift+K".action = move-column-to-monitor-up;

      # Workspace switching (numbered)
      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;

      # Workspace switching (relative)
      "Mod+U".action = focus-workspace-down;
      "Mod+Page_Down".action = focus-workspace-down;
      "Mod+I".action = focus-workspace-up;
      "Mod+Page_Up".action = focus-workspace-up;

      # Move window to workspace (numbered)
      "Mod+Shift+1".action.move-column-to-workspace = 1;
      "Mod+Shift+2".action.move-column-to-workspace = 2;
      "Mod+Shift+3".action.move-column-to-workspace = 3;
      "Mod+Shift+4".action.move-column-to-workspace = 4;
      "Mod+Shift+5".action.move-column-to-workspace = 5;
      "Mod+Shift+6".action.move-column-to-workspace = 6;
      "Mod+Shift+7".action.move-column-to-workspace = 7;
      "Mod+Shift+8".action.move-column-to-workspace = 8;
      "Mod+Shift+9".action.move-column-to-workspace = 9;

      # Move column to workspace (relative)
      "Mod+Ctrl+U".action = move-column-to-workspace-down;
      "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
      "Mod+Ctrl+I".action = move-column-to-workspace-up;
      "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;

      # Move workspace
      "Mod+Shift+U".action = move-workspace-down;
      "Mod+Shift+Page_Down".action = move-workspace-down;
      "Mod+Shift+I".action = move-workspace-up;
      "Mod+Shift+Page_Up".action = move-workspace-up;

      # Column management
      "Mod+Comma".action = consume-window-into-column;
      "Mod+Period".action = expel-window-from-column;
      "Mod+BracketLeft".action = consume-or-expel-window-left;
      "Mod+BracketRight".action = consume-or-expel-window-right;

      # Window sizing
      "Mod+R".action = switch-preset-column-width;
      "Mod+Shift+R".action = switch-preset-window-height;
      "Mod+F".action = maximize-column;
      "Mod+C".action = center-column;
      "Mod+Minus".action = set-column-width "-10%";
      "Mod+Equal".action = set-column-width "+10%";
      "Mod+Shift+Minus".action = set-window-height "-10%";
      "Mod+Shift+Equal".action = set-window-height "+10%";
      "Mod+Ctrl+R".action = reset-window-height;

      # Full-screen and floating
      "Mod+Shift+F".action = fullscreen-window;
      "Mod+V".action = toggle-window-floating;

      # Screenshots
      "Mod+Shift+S".action = spawn "sh" "-c" "grim -g \"$(slurp)\" - | wl-copy";
      "Print".action = spawn "sh" "-c" "grim - | wl-copy";

      # Media / Volume / Brightness
      "XF86AudioRaiseVolume".action = spawn "sh" "-c" "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+";
      "XF86AudioLowerVolume".action = spawn "sh" "-c" "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
      "XF86AudioMute".action = spawn "sh" "-c" "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      "XF86MonBrightnessUp".action = spawn "brightnessctl" "set" "5%+";
      "XF86MonBrightnessDown".action = spawn "brightnessctl" "set" "5%-";
      "XF86AudioPlay".action = spawn "playerctl" "play-pause";
      "XF86AudioNext".action = spawn "playerctl" "next";
      "XF86AudioPrev".action = spawn "playerctl" "previous";

      # Exit
      "Mod+Shift+E".action = quit;
      "Ctrl+Alt+Delete".action = quit;
    };
  };

  # Wallpaper via swaybg (Stylix sets config.stylix.image)
  systemd.user.services.swaybg = {
    Unit = {
      Description = "Wallpaper setter using swaybg";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${pkgs.swaybg}/bin/swaybg -m fill -i ${config.stylix.image}";
      Restart = "on-failure";
    };
    Install.WantedBy = ["graphical-session.target"];
  };

  services.cliphist = {
    enable = true;
    allowImages = true;
  };
}
