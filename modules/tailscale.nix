{ config, ... }:

{
  networking = {
    firewall = {
      checkReversePath = "loose";
      trustedInterfaces = [ "tailscale0" ];
    };
  };

  age.secrets."headscale/authkey".file = ../secrets/headscale/authkey.age;

  services.tailscale = {
    enable = true;
    openFirewall = true;
    interfaceName = "tailscale0";
    authKeyFile = config.age.secrets."headscale/authkey".path;
    extraUpFlags = [
      "--login-server=https://hs.koszyki.zip"
      "--operator=konstanty"

    ];
  };

  # services.resolved = {
  #   enable = true;
  #   dnssec = "false";
  # };

  # systemd.services.tailscaled.after = [
  #   "network-online.target"
  #   "systemd-resolved.service"
  # ];
}

