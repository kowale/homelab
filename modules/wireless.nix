{ config, ... }:

{

  age.secrets.wireless = {
    file = ../secrets/wireless.age;
    owner = "kon";
    group = "wheel";
  };

  networking.wireless = {
    enable = true;
    scanOnLowSignal = false;
    #environmentFile = config.age.secrets.wireless.path;
    networks = {
      #"SKYBEADJ".psk = "@SKYBEADJ@";
      "SKYBEADJ".psk = "changeme";
    };
  };
}
