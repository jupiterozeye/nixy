# Niri is a scrollable-tiling Wayland compositor.
{
  pkgs,
  config,
  lib,
  ...
}: let
  border-size = config.theme.border-size;
  gaps = config.theme.gaps-out;
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
    gnome-themes-extra
    libva
    dconf
    wayland-utils
    wayland-protocols
    glib
    direnv
    fuzzel
    swaylock
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

    spawn-at-startup = [
      {command = ["dbus-update-activation-environment" "--systemd" "--all"];}
    ];

    binds = with config.lib.niri.actions; {
      # Help
      "Mod+Shift+Slash".action = show-hotkey-overlay;

      # Application launching
      "Mod+Return".action = spawn "ghostty";
      "Mod+Space".action = spawn "fuzzel";
      "Super+Alt+L".action = spawn "swaylock";

      # Window management
      "Mod+Q".action = close-window;

      # Focus movement
      "Mod+H".action = focus-column-left;
      "Mod+Left".action = focus-column-left;
      "Mod+L".action = focus-column-right;
      "Mod+Right".action = focus-column-right;
      "Mod+J".action = focus-window-down;
      "Mod+Down".action = focus-window-down;
      "Mod+K".action = focus-window-up;
      "Mod+Up".action = focus-window-up;

      # Move columns
      "Mod+Ctrl+H".action = move-column-left;
      "Mod+Ctrl+Left".action = move-column-left;
      "Mod+Ctrl+L".action = move-column-right;
      "Mod+Ctrl+Right".action = move-column-right;

      # Move windows within column
      "Mod+Ctrl+J".action = move-window-down;
      "Mod+Ctrl+Down".action = move-window-down;
      "Mod+Ctrl+K".action = move-window-up;
      "Mod+Ctrl+Up".action = move-window-up;

      # Focus monitor
      "Mod+Shift+H".action = focus-monitor-left;
      "Mod+Shift+Left".action = focus-monitor-left;
      "Mod+Shift+J".action = focus-monitor-down;
      "Mod+Shift+Down".action = focus-monitor-down;
      "Mod+Shift+K".action = focus-monitor-up;
      "Mod+Shift+Up".action = focus-monitor-up;
      "Mod+Shift+L".action = focus-monitor-right;
      "Mod+Shift+Right".action = focus-monitor-right;

      # Move column to monitor
      "Mod+Ctrl+Shift+H".action = move-column-to-monitor-left;
      "Mod+Ctrl+Shift+Left".action = move-column-to-monitor-left;
      "Mod+Ctrl+Shift+J".action = move-column-to-monitor-down;
      "Mod+Ctrl+Shift+Down".action = move-column-to-monitor-down;
      "Mod+Ctrl+Shift+K".action = move-column-to-monitor-up;
      "Mod+Ctrl+Shift+Up".action = move-column-to-monitor-up;
      "Mod+Ctrl+Shift+L".action = move-column-to-monitor-right;
      "Mod+Ctrl+Shift+Right".action = move-column-to-monitor-right;

      # Workspace switching
      "Mod+U".action = focus-workspace-down;
      "Mod+Page_Down".action = focus-workspace-down;
      "Mod+I".action = focus-workspace-up;
      "Mod+Page_Up".action = focus-workspace-up;

      # Move column to workspace
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
      "Print".action = spawn "sh" "-c" "grim -g \"$(slurp)\" ~/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S.png')";
      "Alt+Print".action = spawn "sh" "-c" "grim -g \"$(slurp -w)\" - | tee ~/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S.png') | wl-copy";
      "Ctrl+Print".action = spawn "sh" "-c" "grim -o $(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name') - | tee ~/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S.png') | wl-copy";

      # Exit
      "Mod+Shift+E".action = quit;
      "Ctrl+Alt+Delete".action = quit;
    };
  };

  services.cliphist = {
    enable = true;
    allowImages = true;
  };
}
