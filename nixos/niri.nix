# Niri is a scrollable-tiling Wayland compositor.
{
  pkgs,
  ...
}: {
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  # XDG portals for screen sharing, etc.
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  };
}
