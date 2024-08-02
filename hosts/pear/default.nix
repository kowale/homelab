{ config, pkgs, lib, ... } @ self:

{

  # TODO: move to nixosModules
  imports = [
    ./hardware-configuration.nix
    ../../modules/nix.nix
    ../../modules/ssh.nix
    ../../modules/git.nix
    ../../modules/zsh.nix
    ../../modules/users.nix
    ../../modules/tmux.nix
    ../../modules/avahi.nix
    ../../modules/zram.nix
    ../../modules/hardening.nix
    ../../modules/tailscale.nix
    ../../modules/ssd.nix
    ../../modules/cli.nix
    ../../modules/hi.nix
    ../../modules/monitoring.nix
    ../../modules/options/user.nix
  ];

  user.name = "kon";
  time.timeZone = "Europe/London";

  users.motd = ''
           _______________
          /              /|
         +--------------+ |
         |.------------.|.|
         ||            ||.|
         ||  pear      || |
         ||            || |
         ||            || |
         |+------------+| |
         +--------------+/
  '';

  nixpkgs.config.allowUnfree = true;
  system.configurationRevision = self.rev or self.dirtyRev or "none";
  system.stateVersion = "23.05";

  services.caddy = {
    enable = true;
    virtualHosts = {

      "docs.pear.local".extraConfig = ''
        encode gzip
        tls internal
        file_server
        root * ${self.outputs.packages.x86_64-linux.docs}
      '';

    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 8000 ];

  networking.hostName = "pear";
  networking.extraHosts = ''
    127.0.0.1 docs.pear.local
  '';

  services.logrotate.enable = true;

  boot.loader = {
    # grub.device = "nodev";
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
    extraModprobeConfig = "options nvidia-drm modeset=1";
    initrd.kernelModules = [
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];
    initrd.systemd.enable = true;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    nvidiaSettings = true;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };


  services.xserver.videoDrivers = [ "nvidia" ];

  services.journald.extraConfig = ''
    SystemMaxUse=100M
    MaxFileSec=5day
  '';

  environment.systemPackages = with pkgs; [
    # linuxPackages.nvidia_x11
    # libGLU
    # libGL
    # cudaPackages_12_2.cudatoolkit
    # cudaPackages.cudnn
  ];

}


