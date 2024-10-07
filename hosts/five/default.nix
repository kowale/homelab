{ config, pkgs, lib, ... } @ self:

{

  # TODO: move to nixosModules
  imports = [
    ./hardware-configuration.nix
    ../../modules/xmonad.nix
    ../../modules/nix.nix
    ../../modules/ssh.nix
    ../../modules/fonts.nix
    ../../modules/pipewire.nix
    ../../modules/git.nix
    ../../modules/zsh.nix
    ../../modules/firefox.nix
    ../../modules/chromium.nix
    ../../modules/users.nix
    ../../modules/wireless.nix
    ../../modules/keepassxc.nix
    ../../modules/tmux.nix
    ../../modules/avahi.nix
    ../../modules/zram.nix
    ../../modules/bluetooth.nix
    ../../modules/hardening.nix
    ../../modules/picom.nix
    ../../modules/laptop.nix
    ../../modules/tailscale.nix
    ../../modules/cursor.nix
    ../../modules/ssd.nix
    ../../modules/cli.nix
    ../../modules/gui.nix
    ../../modules/hi.nix
    ../../modules/restic.nix
    ../../modules/options/user.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  user.name = "kon";

  time.timeZone = "Europe/London";
  networking.hostName = "five";

  users.motd = ''
         +--------------+
         |.------------.|
         ||            ||
         ||     5      ||
         ||            ||
         ||            ||
         |+------------+|
         +-..--------..-+
         .--------------.
        / /============\ \
       / /=========D====\ \
      /____________________\
      \____________________/

  '';

  nixpkgs.config.allowUnfree = true;
  system.configurationRevision = self.rev or self.dirtyRev or "none";
  system.stateVersion = "23.11";

  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      vaapiIntel
      vaapiVdpau
      intel-media-driver
      libvdpau-va-gl
    ];
  };
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.caddy = {
    enable = true;
    virtualHosts = {
      "http://five.local".extraConfig = ''
        root * ${self.outputs.packages.x86_64-linux.docs}
        encode gzip
        file_server
      '';
    };
  };

  # Isn't this default?
  security.pki.certificateFiles = [
    # Firefox certs
    "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
  ];

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  networking.extraHosts = ''
    127.0.0.1 five.local
  '';

  # https://paperless.blog/systemd-services-and-timers-in-nixos
  systemd.services."remind-plan" = {
    enable = false;
    script = ''
      echo $DBUS_SESSION_BUS_ADDRESS
      ${pkgs.libnotify}/bin/notify-send "$(< /home/kon/plan)"
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "kon"; # config.users.users.default.name;
      Environment = [
        # TODO: why %S doesn't work?
        "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus"
      ];
    };

    # systemd-analyze calendar minutely
    startAt = "*:0/15";
  };

  services.tmate-ssh-server = {
    enable = true;
    openFirewall = true;
  };

  programs.kdeconnect.enable = true;
  services.fwupd.enable = true;
  environment.enableDebugInfo = true;

}

