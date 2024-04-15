{ pkgs, lib, inputs, ... }:

# lanzaboote replaces systemd-boot (upstreaming in progress)
# https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md

{

  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  # sudo sbctl verify
  environment.systemPackages = [ pkgs.sbctl ];

  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };

}

