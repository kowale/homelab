{ pkgs, ... }:

{
  virtualisation.docker = {
      enable = true;
      enableOnBoot = true;
      enableNvidia = pkgs.config.cudaSupport;
  };

  # https://github.com/suvash/nixos-nvidia-cuda-python-docker-compose
  systemd.enableUnifiedCgroupHierarchy = false;
}

