{pkgs, ...}: {
  home.packages = with pkgs; [
    mullvad-vpn
    mullvad-browser
  ];

  # Auto-statrt Proton VPN

  wayland.windowManager.hyprland.settings.exec-once = [
    "mullvad-vpn-app --start-minimized &"
  ];
}
