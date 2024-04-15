{ pkgs, ... }:

{

  services.signald.enable = true;

  environment.systemPackages = with pkgs; [
    signaldctl
  ];

}
