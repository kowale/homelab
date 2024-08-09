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
    ../../modules/harmonia.nix
    ../../modules/options/user.nix
    #./passthrough.nix
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

      "http://ollama.pear.local".extraConfig = ''
        encode gzip
        reverse_proxy http://127.0.0.1:11111
      '';

    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 11111 ];

  networking.hostName = "pear";
  networking.extraHosts = ''
    127.0.0.1 docs.pear.local pear.local ok.pear.local ollama.pear.local cache.pear.local
  '';

  services.logrotate.enable = true;

  boot.loader = {
    # grub.device = "nodev";
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot = {
    # TODO: switch to latest when nvidia catches up
    kernelPackages = pkgs.linuxPackages_6_9;
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
    cudatoolkit
    cudaPackages.libcublas
    cudaPackages.libcufft
    cudaPackages.libcurand
    cudaPackages.libcusparse
    cudaPackages.libcusolver
    cudaPackages.cuda_nvrtc
    #cudaPackages.nsight_compute
    libGLU
    libGL
  ];

  nixpkgs.config.cudaSupport = true;

  services.ollama = {
    enable = true;
    acceleration = "cuda";
    listenAddress = "0.0.0.0:11111";
  };

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
    settings = {
      channels = 2;
      encoder = "nvenc";
      #capture = "kms";
      #output_name = 0;
    };
    applications.apps = [
      { name = "alacritty"; cmd = "${pkgs.alacritty}/bin/alacritty"; working-dir = "/tmp"; }
      { name = "xterm"; cmd = "${pkgs.xterm}/bin/xterm"; working-dir = "/tmp"; }
      { name = "chromium"; cmd = "${pkgs.chromium}/bin/chromium"; working-dir = "/tmp"; }
    ];
  };

  services.xserver = {
    enable = true;
    dpi = 80;
    exportConfiguration = true;
    resolutions = [
      { x = 1920; y = 1080; }
    ];
    virtualScreen =
      { x = 1920; y = 1080; };
  };
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.displayManager.autoLogin = {
    enable = true;
    user = "kon";
  };
}


