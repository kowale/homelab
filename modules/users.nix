{ config, ... }:

let

    keys = import ../secrets/keys.nix;

in

{
  security.sudo = {
    wheelNeedsPassword = false;
    execWheelOnly = true;
  };

  users.users.kon = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "docker" "input" ];
    # passwordFile = age.secrets.kon.path;
    openssh.authorizedKeys.keys = keys.kon;
  };
}
