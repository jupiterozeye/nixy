{
  pkgs,
  config,
  ...
}: {
  imports = [
    # Programs
    ../../home/programs/brave
    ../../home/programs/bitwarden
    ../../home/programs/ghostty
    ../../home/programs/nvf
    ../../home/programs/shell
    ../../home/programs/fetch
    ../../home/programs/git
    ../../home/programs/git/lazygit.nix
    #../../home/programs/git/signing.nix # Change the key or remove this file
    #../../home/programs/spicetify
    ../../home/programs/thunar
    #../../home/programs/discord
    ../../home/programs/nixy
    ../../home/programs/zathura
    ../../home/programs/nightshift
    ../../home/programs/group/cybersecurity.nix
    ../../home/programs/its-clipped
    ../../home/programs/context
    ../../home/programs/tornado
    #../../home/programs/kimi

    # System (Desktop environment like stuff)
    ../../home/system/hyprland
    ../../home/system/niri
    ../../home/system/noctalia-shell
    ../../home/system/mime
    ../../home/system/udiskie

    ./variables.nix # Mostly user-specific configuration
    #./secrets # CHANGEME: You should probably remove this line, this is where I store my secrets
  ];

  home = {
    packages = with pkgs; [
      # Apps
      vlc # Video player
      blanket # White-noise app
      obsidian # Note taking app
      textpieces # Manipulate texts
      resources # Ressource monitor
      gnome-clocks # Clocks app
      gnome-text-editor # Basic graphic text editor
      mpv # Video player
      ticktick # Todo app
      signal-desktop # Signal app, private messages
      stirling-pdf # TODO: Server version
      # calibre  # Temporarily disabled - qtbase/qmake build issue in nixpkgs
      spotifywm
      p2pool

      # Dev
      go
      bun
      nodejs
      python3
      jq
      just
      pnpm
      air
      duckdb
      opencode
      distrobox
      direnv
      devenv
      jan
      wails
      sillytavern
      docker-compose
      tailscale
      bun
      wl-clipboard
      claude-code

      steam

      # Just cool
      peaclock
      cbonsai
      pipes
      cmatrix
      fastfetch
      moonlight-qt

      # Backup
    ];

    inherit (config.var) username;
    homeDirectory = "/home/" + config.var.username;

    # Import a profile picture
    file.".face" = {source = ./jupiter.png;};

    # Don't touch this
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;

  # Worklaptop-specific Niri settings
  # NOTE: Monitor connector names may differ from Hyprland due to NVIDIA PRIME.
  # After first boot into Niri, run `niri msg outputs` to verify and adjust.
  programs.niri.settings.outputs = {
    "DP-9" = {
      mode = {width = 1920; height = 1080; refresh = 60.0;};
      position = {x = 0; y = 0;};
    };
    "DP-10" = {
      mode = {width = 1920; height = 1080; refresh = 60.0;};
      position = {x = 1920; y = 0;};
    };
    "eDP-1" = {
      mode = {width = 1920; height = 1200; refresh = 60.0;};
      position = {x = 1920; y = 1080;};
    };
    "DP-8" = {
      mode = {width = 3840; height = 2160; refresh = 60.0;};
      position = {x = 3840; y = 0;};
      scale = 1.5;
    };
  };

  programs.niri.settings.environment = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    DISPLAY = ":0";
  };
}
