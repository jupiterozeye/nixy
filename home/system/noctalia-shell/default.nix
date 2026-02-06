# Noctalia Shell Home Manager Configuration
# See https://github.com/noctalia-dev/noctalia-shell
{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;
    package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
    
    settings = {
      general = {
        apps = {
          terminal = ["ghostty"];
          audio = ["pavucontrol"];
          explorer = ["thunar"];
        };
        
        idle.timeouts = [];
      };
      
      services.weatherLocation = "Paris";
    };
  };

  home.packages = with pkgs; [
    gpu-screen-recorder
  ];
}