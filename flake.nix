{
  # https://github.com/anotherhadi/nixy
  description = ''
    Nixy simplifies and unifies the Hyprland ecosystem with a modular, easily customizable setup.
    It provides a structured way to manage your system configuration and dotfiles with minimal effort.
  '';

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    stylix.url = "github:danth/stylix";
    nixcord.url = "github:kaylorben/nixcord";
    sops-nix.url = "github:Mic92/sops-nix";
    nvf.url = "github:notashelf/nvf";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";
    its-clipped.url = "github:jupiterozeye/its-clipped";
    context.url = "github:jupiterozeye/context";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    caelestia-cli = {
      url = "github:caelestia-dots/cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Server
    eleakxir.url = "github:anotherhadi/eleakxir";
    nixarr.url = "github:rasmus-kirk/nixarr";
  };

  outputs = inputs @ {nixpkgs, ...}: {
    nixosConfigurations = {
      worklaptop = nixpkgs.lib.nixosSystem {
        modules = [
          {
            nixpkgs.overlays = [];
            _module.args = {
              inherit inputs;
            };
          }
          inputs.home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix
          ./hosts/worklaptop/configuration.nix
        ];
      };
      homelaptop = nixpkgs.lib.nixosSystem {
        modules = [
          {
            nixpkgs.overlays = [inputs.niri.overlays.niri];
            _module.args = {
              inherit inputs;
            };
          }
          inputs.home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix
          inputs.niri.nixosModules.niri
          ./hosts/homelaptop/configuration.nix
        ];
      };
    };
  };
}
