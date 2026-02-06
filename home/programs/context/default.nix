# Context - Terminal context capture tool for AI-assisted debugging
{
  pkgs,
  inputs,
  ...
}: {
  home.packages = [
    inputs.context.packages.${pkgs.system}.default
  ];
}
