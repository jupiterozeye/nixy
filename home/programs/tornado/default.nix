{
  inputs,
  pkgs,
  ...
}: {
  home.packages = [
    inputs.tornado.packages.${pkgs.system}.default
  ];
}
