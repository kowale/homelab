{ config, pkgs, ... }:

{
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
        antialias = true;
        defaultFonts = {
          monospace = [ "Terminus" ];
        };
    };

    fonts.packages = with pkgs; [
        dejavu_fonts
        noto-fonts
        fira-code
        terminus_font
        inter
    ];
}

