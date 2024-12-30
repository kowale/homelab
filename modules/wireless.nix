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
      "VOO-GRBLGF7".psk = "@VOO_GRBLGF7@";
      "ikon".psk = "@ikon@";
      "eduroam".auth = ''
        key_mgmt=WPA-EAP
        pairwise=CCMP
        group=CCMP TKIP
        eap=PEAP
        ca_cert="${../secrets/public/eduroam-imperial-ca.pem}"
        identity="kjk24@ic.ac.uk"
        altsubject_match="DNS:wireless.ic.ac.uk"
        phase2="auth=MSCHAPV2"
        password="@eduroam@"
      '';
    };
  };
}
