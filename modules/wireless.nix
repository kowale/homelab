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
    secretsFile = config.age.secrets.wireless.path;
    networks = {
      "SKYBEADJ" = {
        pskRaw = "ext:SKYBEADJ";
        priority = 10;
      };

      "eduroam" = {
        priority = 5;
        auth = ''
          key_mgmt=WPA-EAP
          pairwise=CCMP
          group=CCMP TKIP
          eap=PEAP
          ca_cert="${../secrets/public/eduroam-imperial-ca.pem}"
          identity="kjk24@ic.ac.uk"
          altsubject_match="DNS:wireless.ic.ac.uk"
          phase2="auth=MSCHAPV2"
          password=ext:eduroam
        '';
      };

      "ikon".pskRaw = "ext:ikon";
      "SKYKDEKR".pskRaw = "ext:SKYKDEKR";
      "VOO-GRBLGF7".pskRaw = "ext:VOO_GRBLGF7";
      "Marteau Happy Activities".pskRaw = "ext:MHA";
      "Selestine Villa".pskRaw = "ext:SV";
    };
  };
}
