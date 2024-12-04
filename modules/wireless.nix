{ config, pkgs, ... }:

{

  # networking.dhcpcd.enable = false;
  # systemd.network.enable = true;

  # systemd.network.networks."10-lan" = {
  #   matchConfig.Name = "lan";
  #   networkConfig = {
  #     DHCP = "ipv4";
  #     # LinkLocalAddressing = "no";
  #   };
  # };

  # systemd.services."systemd-networkd".environment.SYSTEMD_LOG_LEVEL = "debug";

  age.secrets.wireless = {
    file = ../secrets/wireless.age;
    owner = "kon";
    group = "wheel";
  };

  networking.wireless = {
    enable = true;
    userControlled.enable = true;
    scanOnLowSignal = false;
    environmentFile = config.age.secrets.wireless.path;
    networks = {
      "SKYBEADJ".psk = "@SKYBEADJ@";
      "SKYKDEKR".psk = "@SKYKDEKR@";
      "VOO-GRBLGF7".psk = "@VOO_GRBLGF7@";
      "BT-2WCM2F".psk = "@BT_2WCM2F@";
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

  environment.systemPackages = [ pkgs.wpa_supplicant_gui ];

}
