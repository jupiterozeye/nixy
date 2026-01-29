# NVF is a Neovim configuration that provides a minimal setup with essential plugins and configurations.
{inputs, ...}: {
  imports = [
    inputs.its-clipped.homeManagerModules.default
  ];

  programs.its-clipped = {
    enable = true;
  };
}
