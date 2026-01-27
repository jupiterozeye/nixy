# Home-manager configuration for NixOS
{inputs, pkgs, ...}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    # Use a custom backup command to handle conflicts automatically
    # This moves files to a timestamp-based backup location
    backupCommand = "${pkgs.bash}/bin/bash -c 'mv -v \"$1\" \"$1.hm-backup-$(date +%s)\"' _";
    extraSpecialArgs = {inherit inputs;};
  };
}
