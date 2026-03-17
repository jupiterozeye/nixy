# Bitwarden desktop — temporarily disabled due to broken Electron 39 in nixpkgs unstable.
# Re-enable when upstream fixes the electron-unwrapped-39 build.
# See: https://github.com/NixOS/nixpkgs/issues (electron 39 angle patch)
{pkgs, ...}: {
  home.packages = [
    # pkgs.bitwarden-desktop
  ];
}
