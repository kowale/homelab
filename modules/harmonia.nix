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

  networking.firewall.allowedTCPPorts = [ 5000 ];

  services.harmonia = {
    enable = true;
    signKeyPath = config.age.secrets."binary_cache_key".path;
  };

  nix.settings = {
    substituters = [ "http://cache.pear.local" ];
    trusted-public-keys = [ "cache.pear.local:NdBzAs/wPQnM5PYbpwtyA32z+eDpQ+czQKO+IwvTbkQ=" ];
  };
}
