{ config, pkgs, lib, ... }:

let

  indexThemeText = theme: lib.generators.toINI {}
    {"icon theme" = { Inherits = "${theme}"; }; };

  mkDefaultCursorFile = theme: pkgs.writeTextDir
    "share/icons/default/index.theme"
    "${indexThemeText theme}";

  cursorTheme = mkDefaultCursorFile "Adwaita";

in {

  environment.systemPackages = [
    cursorTheme
    pkgs.gnome.adwaita-icon-theme
  ];

}
