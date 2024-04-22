{ config, ... }:

# TODO: it seems agenix mangles the private key
# nix-store --generate-binary-cache-key twelve.local:5000 twelve_binary_cache_key.secret twelve_binary_cache_key.pub

{
  age.secrets."twelve_binary_cache_key" = {
    file = ../secrets/twelve_binary_cache_key.age;
    owner = "harmonia";
    group = "harmonia";
  };

  networking.firewall.allowedTCPPorts = [ 5000 ];

  services.harmonia = {
    enable = true;
    signKeyPath = config.age.secrets."twelve_binary_cache_key".path;
  };

  nix.settings = {
    substituters = [ "http://twelve.local:5000" ];
    trusted-public-keys = [ "twelve.local:5000:l8+oMRAlISC2+5cM2A1OcT2NNWF1PR20uButyQ1R3ng=" ];
  };
}
