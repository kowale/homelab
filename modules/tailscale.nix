{
  networking = {
    useNetworkd = true;
    firewall = {
      checkReversePath = "loose";
      trustedInterfaces = [ "tailscale0" ];
    };
  };

  # sudo tailscale up
  # tailscale status
  services.tailscale.enable = true;

  services.resolved = {
    enable = true;
    dnssec = "false";
  };

  systemd.services.tailscaled.after = [ "network-online.target" "systemd-resolved.service" ];
}

