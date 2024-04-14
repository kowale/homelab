{ config, pkgs, ... }:

# https://security.stackexchange.com/questions/215202/how-secure-is-keepass-kdbx4-by-default
# https://github.com/keepassxreboot/keepassxc/discussions/9506
# https://github.com/keepassxreboot/keepassxc/pull/10311

let

  hello = pkgs.writeShellScriptBin "" ''
    echo hi
  '';

in {

  environment.systemPackages = with pkgs; [
    keepassxc
  ];

  age.secrets."homelab.kdbx.tar".file = ../secrets/homelab.kdbx.tar.age;

}
