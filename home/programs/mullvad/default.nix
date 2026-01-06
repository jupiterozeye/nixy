{pkgs, ...}: let
  mullvadReconnect = pkgs.writeShellScriptBin "mullvad-reconnect-on-start" ''
    ${pkgs.mullvad}/bin/mullvad disconnect || true
    sleep 0.1
    ${pkgs.mullvad}/bin/mullvad connect || true
  '';
in {
  home.packages = with pkgs; [
    mullvad-vpn
    mullvadReconnect
  ];

  wayland.windowManager.hyprland.settings.exec-once = [
    "${mullvadReconnect}/bin/mullvad-reconnect-on-start"
  ];
}
