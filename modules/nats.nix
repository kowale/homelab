{ pkgs, config, ... }:

{
  environment.systemPackages = [ pkgs.natscli ];

  services.nats = {
    enable = true;
    port = 4222;
    serverName = config.networking.hostName;
    jetstream = true;
  };
}
