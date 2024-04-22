{ config, ... }:

let

    keys = import ../secrets/keys.nix;

in

{
  security.sudo = {
    wheelNeedsPassword = false;
    execWheelOnly = true;
  };

  age.secrets."kon" = {
    owner = "kon";
    group = "wheel";
    file = ../secrets/kon.age;
  };

  # users.mutableUsers = false;

  users.users.kon = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" ];
    password = "kon";
    # passwordFile = age.secrets.kon.path;
    openssh.authorizedKeys.keys = keys.kon;
  };
}
