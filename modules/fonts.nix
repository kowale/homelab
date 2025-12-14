{ config, pkgs, ... }:

{

  # Console logins automatically
  services.getty = {
    autologinUser = "kon";
    helpLine = ''
      Press `i`
    '';
    greetingLine = "\l";
  };
  console = {
    keyMap = "us";
    earlySetup = true;
    packages = [ pkgs.terminus_font ];
    font = "ter-u12n";
  };

  i18n.defaultLocale = "en_US.UTF-8";

  fonts.enableDefaultPackages = true;

  fonts.fontconfig = {
    enable = true;
    cache32Bit = true;
    hinting.enable = true;
    antialias = true;
    defaultFonts = {
      monospace = [ "Terminus" ];
      sansSerif = [ "DejaVu Sans" ];
      serif = [ "DejaVu Serif" ];
    };
  };

  fonts.packages = with pkgs; [
    dejavu_fonts
    terminus_font
    inter
    noto-fonts-color-emoji
    ipafont # Japanese
    uiua386
  ];
}

