{ config, ... }:

# TODO: it seems agenix mangles the private key
# nix-store --generate-binary-cache-key cache.pear.local priv pub

{
  assertions = [
    { assertion = config.networking.hostName == "pear"; message = "Only implemented for pear.local"; }
  ];

  age.secrets."binary_cache_key" = {
    file = ../secrets/binary_cache_key.age;
    owner = "harmonia";
    group = "harmonia";
  };

  networking.firewall.allowedTCPPorts = [ 443 80 ];

  services.harmonia = {
    enable = true;
    settings = {
      priority = 20;
      bind = "127.0.0.1:5000";
    };
    signKeyPath = config.age.secrets."binary_cache_key".path;
  };

  nix.settings = {
    substituters = [ "https://cache.pear.local" ];
    trusted-public-keys = [ "cache.pear.local:NdBzAs/wPQnM5PYbpwtyA32z+eDpQ+czQKO+IwvTbkQ=" ];
  };

  services.caddy = {
    enable = true;
    virtualHosts."cache.pear.local".extraConfig = ''
      encode zstd gzip {
        match {
          header Content-Type application/x-nix-archive
        }
      }
      reverse_proxy ${config.services.harmonia.settings.bind}
    '';
  };

}
