# docker run --rm --gpus all nvidia/cuda:<find me> nvidia-smi

{ config, pkgs, ... }:

let

  inherit (config.nixpkgs.config) cudaSupport;

in {

  environment.systemPackages = with pkgs; [
    # docker
    # nvidia-docker
  ];

  virtualisation.docker = {
      enable = true;
      enableOnBoot = true;
      # enableNvidia = cudaSupport;
      # extraOptions = "--gpus=all --default-runtime=nvidia";
  };

  # https://github.com/suvash/nixos-nvidia-cuda-python-docker-compose
  systemd.enableUnifiedCgroupHierarchy = false;

}

