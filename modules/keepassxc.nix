{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    keepassxc
  ];

  age.secrets."homelab.kdbx".file = ../secrets/homelab.kdbx.age;

}
