{pkgs, ...}: {
  home.packages = with pkgs; [
    mullvad-vpn
    mullvad-browser
  ];

  wayland.windowManager.hyprland.settings.exec-once = [
    "mullvad-vpn &"
  ];
}
