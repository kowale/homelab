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
    ../../modules/monitoring.nix
    ../../modules/docker.nix
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

  # services.nginx.enable = true;
  # services.nginx.virtualHosts."spar.five.local" = {
  #     locations."/".proxyPass = "http://127.0.0.1:8000";
  #   };

  environment.systemPackages = with pkgs; [
    nss.tools
  ];

  services.caddy = {
    enable = true;
    virtualHosts = {

      "http://five.local".extraConfig = ''
        respond respond "meta"
      '';

      "five.five.local".extraConfig = ''
        tls /tmp/cert.pem /tmp/key.pem
        respond "5"
      '';

      "ok.five.local".extraConfig = ''
        tls internal
        respond "OK"
      '';

      "spar.five.local".extraConfig = ''
        tls internal
        encode gzip
        reverse_proxy http://127.0.0.1:8000
      '';

      "docs.five.local".extraConfig = ''
        tls internal
        root * ${self.outputs.packages.x86_64-linux.docs}
        encode gzip
        file_server
      '';

    };
  };

  # security.pki.certificateFiles = [
  #   "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
  # ];

  security.pki.certificates = [
    ''
    -----BEGIN CERTIFICATE-----
    MIIBozCCAUmgAwIBAgIQe3Hk7zDQOXUssf2ShXZcmjAKBggqhkjOPQQDAjAwMS4w
    LAYDVQQDEyVDYWRkeSBMb2NhbCBBdXRob3JpdHkgLSAyMDI0IEVDQyBSb290MB4X
    DTI0MDUyMTE3NTczM1oXDTM0MDMzMDE3NTczM1owMDEuMCwGA1UEAxMlQ2FkZHkg
    TG9jYWwgQXV0aG9yaXR5IC0gMjAyNCBFQ0MgUm9vdDBZMBMGByqGSM49AgEGCCqG
    SM49AwEHA0IABK1hxOW9/mADwKaDgEUH2U1WE4LaLpgUkvTYyRHsjx9EVvbZ86n7
    hQz8TFwiQprDCdLwqNFHsL1/tU+DWeqA1OejRTBDMA4GA1UdDwEB/wQEAwIBBjAS
    BgNVHRMBAf8ECDAGAQH/AgEBMB0GA1UdDgQWBBTapL3LwSWrMzg8SYIERkyQFs7v
    wjAKBggqhkjOPQQDAgNIADBFAiEA8vLPReCK/WV7R6XL2A3LX5PJeFdAimcyvntX
    9s0+Wg4CIFPRGEHFoAYF2NNvKKoExMXnhumMfyhHFAEwOp8bHWVy
    -----END CERTIFICATE-----
    ''
  ];

  nix.settings = {
    substituters = [ "http://cache.pear.local" ];
    trusted-public-keys = [ "cache.pear.local:NdBzAs/wPQnM5PYbpwtyA32z+eDpQ+czQKO+IwvTbkQ=" ];
  };

  networking.firewall.allowedTCPPorts = [ 80 443 8000 ];

  networking.extraHosts = ''
    127.0.0.1 docs.five.local spar.five.local
    127.0.0.1 ok.five.local five.five.local
    192.168.0.42 cache.pear.local
    192.168.0.42 grafana.pear.local
    192.168.0.42 prometheus.pear.local
    192.168.0.42 webhook.pear.local
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

  # security.pki.certificateFiles = [

  # ];
}

