{pkgs, ...}: {
  # NetworkManager dispatcher script
  # Runs when network interfaces come up/down
  # Adds route to 192.168.0.0/24 after network is stable

  systemd.services.NetworkManager-dispatcher.enable = true;

  # Dispatcher script that runs on network events
  environment.etc."NetworkManager/dispatcher.d/99-local-routes" = {
    mode = "0755";
    text = ''
      #!/bin/sh
      # NetworkManager Dispatcher Script
      # Adds static route to 192.168.0.0/24 subnet

      INTERFACE="$1"
      ACTION="$2"

      # Only run on interface up
      if [ "$ACTION" = "up" ]; then
        # Add route via gateway 192.168.10.1
        # Metric 50 (lower than default 100) gives priority
        ${pkgs.iproute2}/bin/ip route add 192.168.0.0/24 via 192.168.10.1 dev "$INTERFACE" metric 50 2>/dev/null || true
      fi
    '';
  };
}
