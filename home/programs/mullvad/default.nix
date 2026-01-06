{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    mullvad-vpn
    mullvad-browser
  ];

  # Configure Mullvad VPN daemon as a user service
  systemd.user.services.mullvad-daemon = {
    Unit = {
      Description = "Mullvad VPN daemon";
      After = ["network.target"];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.mullvad-vpn}/bin/mullvad-daemon --disable-stdout-timestamps";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = ["default.target"];
    };
  };

  # Auto-start the service and GUI
  wayland.windowManager.hyprland.settings.exec-once = [
    "systemctl --user enable --now mullvad-daemon.service"
    "mullvad-vpn --start-minimized &"
  ];
}
