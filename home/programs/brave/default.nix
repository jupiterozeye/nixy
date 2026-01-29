{pkgs, ...}: {
  programs.brave = {
    enable = true;
    commandLineArgs = [
      "--no-default-browser-check"
      "--ozone-platform-hint=auto"
      "--enable-features=VaapiVideoDecoder"
      "--disable-features=UseChromeOSDirectVideoDecoder"
    ];
  };

  home.sessionVariables = {
    DEFAULT_BROWSER = "${pkgs.brave}/bin/brave";
  };
}
