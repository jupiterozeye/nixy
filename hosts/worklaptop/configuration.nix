{config, ...}: {
  imports = [
    # Mostly system related configuration
    ../../nixos/nvidia.nix # CHANGEME: Remove this line if you don't have an Nvidia GPU
    ../../nixos/audio.nix
    ../../nixos/bluetooth.nix
    ../../nixos/fonts.nix
    ../../nixos/home-manager.nix
    ../../nixos/nix.nix
    ../../nixos/systemd-boot.nix
    ../../nixos/users.nix
    ../../nixos/utils.nix
    ../../nixos/tailscale.nix
    ../../nixos/hyprland.nix
    ../../nixos/niri.nix
    ../../nixos/podman.nix
    ../../nixos/local-network-routes.nix
    # ../../nixos/mullvad.nix

    # You should let those lines as is
    ./hardware-configuration.nix
    ./variables.nix
  ];

  home-manager.users."${config.var.username}" = import ./home.nix;

  # GDM display manager (supports both Niri and Hyprland sessions)
  services.displayManager.gdm.enable = true;
  services.displayManager.gdm.wayland = true;

  # Don't touch this
  system.stateVersion = "24.05";
}
