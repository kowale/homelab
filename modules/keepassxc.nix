{ config, pkgs, ... }:

# https://security.stackexchange.com/questions/215202/how-secure-is-keepass-kdbx4-by-default
# https://github.com/keepassxreboot/keepassxc/discussions/9506
# https://github.com/keepassxreboot/keepassxc/pull/10311

let

  openSesame = pkgs.writeShellScriptBin "openSesame" ''
    dir=$(mktemp)
    cd $dir
    tar xf ${config.age.secrets."homelab.kdbx.tar".path}
    keepassxc homelab.kdbx
  '';

in {

  environment.systemPackages = with pkgs; [
    keepassxc
    openSesame
  ];


  age.secrets."homelab.kdbx.tar" = {
    file = ../secrets/homelab.kdbx.tar.age;
    owner = "kon";
    group = "wheel";
  };

}
