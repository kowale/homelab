{ config, pkgs, ... }:

{
    fonts.enableDefaultPackages = true;
    console.keyMap = "us";
    i18n.defaultLocale = "en_US.UTF-8";

    fonts.fontconfig = {
        enable = true;
        antialias = true;
    };

    fonts.packages = with pkgs; [
        dejavu_fonts
        noto-fonts
        fira-code
        dina-font
        proggyfonts
        terminus_font
        iosevka
        inter
    ];
}

