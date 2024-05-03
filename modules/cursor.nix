{ config, pkgs, lib, ... }:

let

  /*
  /run/current-system/sw/share/themes/Dracula/
  [icon theme]
  Inherits=WhiteSur-cursors
  */
  indexThemeText = theme: lib.generators.toINI {}
    {
      "icon theme" = { Inherits = "${theme}"; };
    };

  mkDefaultCursorFile = theme: pkgs.writeTextDir
    "share/icons/default/index.theme"
    "${indexThemeText theme}";

in {

  environment.etc."xdg/gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-overlay-scrolling = false
    gtk-button-images=0
    gtk-menu-images=0
    gtk-enable-event-sounds=0
    gtk-enable-input-feedback-sounds=0
  '';

  environment.systemPackages = with pkgs; [
    themechanger
    xorg.xcursorthemes
    dracula-theme
    papirus-icon-theme
    vanilla-dmz
    whitesur-cursors

    # (mkDefaultCursorFile "Vanilla-DMZ")
    # (mkDefaultCursorFile "whiteglass")
    (mkDefaultCursorFile "WhiteSur-cursors")
  ];

}
