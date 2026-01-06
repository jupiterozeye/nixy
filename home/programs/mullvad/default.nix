{pkgs, ...}: {
  home.packages = with pkgs; [
    mullvad-vpn
    mullvad-browser
  ];

  # Auto-start mullvad VPN

  wayland.windowManager.hyprland.settings.exec-once = [
    "mullvad-daemon --start-minimized &"
  ];
}
