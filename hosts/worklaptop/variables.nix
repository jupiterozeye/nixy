{
  config,
  lib,
  ...
}: {
  imports = [
    # Choose your theme here:
    ../../themes/everforest.nix
  ];

  config.var = {
    hostname = "worklaptop";
    username = "jupi";
    configDirectory =
      "/home/"
      + config.var.username
      + "/.config/nixos"; # The path of the nixos configuration directory

    keyboardLayout = "us";

    location = "Paris";
    timeZone = "Europe/Paris";
    defaultLocale = "en_US.UTF-8";
    extraLocale = "fr_FR.UTF-8";

    git = {
      username = "jupiterozeye";
      email = "ozeye@tutamail.com";
    };

    autoUpgrade = false;
    autoGarbageCollector = true;
  };

  # DON'T TOUCH THIS
  options = {
    var = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };
  };
}
