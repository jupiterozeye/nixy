{config, inputs, lib, ...}: {
  imports = [
    # Mostly system related configuration
    ../../nixos/audio.nix
    ../../nixos/bluetooth.nix
    ../../nixos/fonts.nix
    ../../nixos/home-manager.nix
    ../../nixos/nix.nix
    ../../nixos/systemd-boot.nix
    # ../../nixos/sddm.nix  # Don't use SDDM for homelaptop
    ../../nixos/users.nix
    ../../nixos/utils.nix
    ../../nixos/tailscale.nix
    ../../nixos/niri.nix
    ../../nixos/podman.nix
    ../../nixos/local-network-routes.nix
    # ../../nixos/mullvad.nix

    # You should let those lines as is
    ./hardware-configuration.nix
    ./variables.nix
  ];

  home-manager.users."${config.var.username}" = import ./home.nix;

  # Use GDM instead of SDDM for homelaptop (works better with niri)
  services.displayManager.gdm.enable = true;
  services.displayManager.gdm.wayland = true;

  # Don't touch this
  system.stateVersion = "24.05";
}
