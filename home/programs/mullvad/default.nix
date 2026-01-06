{pkgs, ...}: {
  home.packages = with pkgs; [
    mullvad-vpn
    mullvad-browser
  ];
}
