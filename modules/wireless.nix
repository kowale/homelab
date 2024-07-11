{ config, pkgs, ... }:

{

  age.secrets.wireless = {
    file = ../secrets/wireless.age;
    owner = "kon";
    group = "wheel";
  };

  environment.systemPackages = [ pkgs.wpa_supplicant_gui ];

  networking.wireless = {
    enable = true;
    userControlled.enable = true;
    scanOnLowSignal = false;
    environmentFile = config.age.secrets.wireless.path;
    networks = {
      "SKYBEADJ".psk = "@SKYBEADJ@";
      "SKYKDEKR".psk = "@SKYKDEKR@";
      "VOO-GRBLGF7".psk = "@VOO-GRBLGF7@";
    };
  };
}
