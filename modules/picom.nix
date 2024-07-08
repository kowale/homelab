/*

Xorg allows an external process
to manage how off-screen buffers
are merged with on-screen buffers
e.g. fade or blur window tooltips.
DEs often have compositors, WMs not.
Picom is a compositor for Xorg.

*/

{
  services.picom = {
    enable = true;
    vSync = true;
    settings = {
      max-brightness = 1.0;
      use-damage = false;
    };
  };
}
