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

  environment.etc."/self/key.pem".text = ''
    -----BEGIN PRIVATE KEY-----
    MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC8wdvcIrOG4jTO
    5UIJ3iu+m5KWQRB4cB9WVLMxV7uaN9ZvL7UdonafVZe1Xd9IWFfp1lgJuBK2EdMj
    iN6OEy27CM8hjI5wIcpoqBql+Cj+paxHtUbhQPNeJPHfVURNvfy+ijJ0NEyHScwI
    cY/6Imk2Rg/RuSMhm3HBUrk92zXMJUmxi6KU5EclSvWjMku+QwO881ohld6lZqMc
    ylMZhS+cTrpfGeqk1W3Xu//KUCccvMRa8SER3Xx7w53P2WF7KUqgEC17V9Yw5l3b
    GYjaNicgB+CZfXF4d4vyhuAghBQq/WJxPr/jk+rDUOV02v+mRmM//Sp/yB8ulMV1
    g1MHGwLNAgMBAAECggEAAtQ7/Zlmi+29gWFVw0yZZr6xrH9Wpht2GMbltaZdOTM/
    i0SRiBtsgDhZ8P2ycETksmxEPwcLfr+XJMfzH/mBHLXF1viilOMow7dLSPQGd0SX
    5647nPoqe519o42FW83uaROsrGmxQPDV9kVvdT4JSic0Kv5FnMYV5yIchSURMhlR
    YG7pXLLpDypzb4r1sLTjNvRGaBMSyaIBlJYldyMiBhAc8Z/XqJmAIlvy52AMQNaI
    njPQKhxcAzihMeiLjSoYeV+fmXhox6o/0fNaBVIJHnOVyUzsfVvt7wcLr2ITzouv
    QG6/2coARur47U7eVW3xBqZWX2BNrIsX+DXRMiMV4QKBgQDk4bVVq8bXDSqb1F0j
    Nhllmi4/iJzGn7YkijuKXEh2gJOcAPKFT44Is8GRk8hMolcSlOm6NqgaI2PAPWl8
    vc0TQlL0BgCjN/9SC3bJriDnUgdTQbCSEciXwRMmu/YUD2xknRHlbWgakusBTKea
    prU6yIH3OzgW1cEF/3zR3J1UrQKBgQDTHx9k7LFXUJ1LaPSAxo/vGfn7bUIa5oh/
    deUaXyAkgBn8GUYkIGU9sTdIiIKbgGHL56rqCUSZQEttn4k/+CiC01I+lM8WSLYu
    v39PH47pinJiPToQhUNN3Bo1eCne2IXFstCVQV4peYD4vRJSvfKk06Xv58yMyPT5
    b7IWD4IKoQKBgQCTkzRoWKmMX2DpuLOU0HzvlcncDSmIp9G5HafmPjo6rgx+ud2l
    NvZNhhl40+CCCOo7gOhyuGsK72aRvQcW9woTMOBrlrMyihiFvf6Ja0yr2af/doty
    oyTDNCo0/1xa8tbgyKWRWEmXWMNNwy8N+A9CJ6Yk0noHvysFwwWoCqcmwQKBgEgj
    FT4N5haYk/ZlWU37Csk/DfyL+49nf/JVXT/iiwANyVMra50CeLVYrTQaeM4bUs8y
    TGMFYawfnOZLIcF60JTLEgoSHKRXmfBlPGHTvagsxyKsGv/0GOgsscPdWCktwJ+p
    lr25BSyUuK3FJNKi1prdOpC7mlfsflAQi0AgcmWhAoGADRDGqPQw1C2UIEvbKfts
    ZFvn4KVfHLqJZgyQy5qlchXROe2LgWQ/u+/YAcnfBtfuWdNRZusgyQQAIaeSccpw
    CEKpVJxRgA6xbkMvF8F1DVaP6AC8lFerJQM/qDctz5bP7pzlvGQPhtOgcUJ5U9wm
    JfRvVJZljoQxU0wY/fg7aaU=
    -----END PRIVATE KEY-----
  '';

  environment.etc."/self/cert.pem".text = ''
    -----BEGIN CERTIFICATE-----
    MIIDtzCCAp+gAwIBAgIUep9IjFF1CNxh12w1jkZxpW3DUvswDQYJKoZIhvcNAQEL
    BQAwazELMAkGA1UEBhMCVUsxDzANBgNVBAgMBkxvbmRvbjEPMA0GA1UEBwwGTG9u
    ZG9uMRAwDgYDVQQKDAdLb3N6eWtpMRQwEgYDVQQLDAtFbmdpbmVlcmluZzESMBAG
    A1UEAwwJS29uc3RhbnR5MB4XDTI0MDgwMzE5NTM1M1oXDTI1MDgwMzE5NTM1M1ow
    azELMAkGA1UEBhMCVUsxDzANBgNVBAgMBkxvbmRvbjEPMA0GA1UEBwwGTG9uZG9u
    MRAwDgYDVQQKDAdLb3N6eWtpMRQwEgYDVQQLDAtFbmdpbmVlcmluZzESMBAGA1UE
    AwwJS29uc3RhbnR5MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvMHb
    3CKzhuI0zuVCCd4rvpuSlkEQeHAfVlSzMVe7mjfWby+1HaJ2n1WXtV3fSFhX6dZY
    CbgSthHTI4jejhMtuwjPIYyOcCHKaKgapfgo/qWsR7VG4UDzXiTx31VETb38vooy
    dDRMh0nMCHGP+iJpNkYP0bkjIZtxwVK5Pds1zCVJsYuilORHJUr1ozJLvkMDvPNa
    IZXepWajHMpTGYUvnE66XxnqpNVt17v/ylAnHLzEWvEhEd18e8Odz9lheylKoBAt
    e1fWMOZd2xmI2jYnIAfgmX1xeHeL8obgIIQUKv1icT6/45Pqw1DldNr/pkZjP/0q
    f8gfLpTFdYNTBxsCzQIDAQABo1MwUTAdBgNVHQ4EFgQUlzkplPACB2aNTWtf9SAM
    LOXe4oQwHwYDVR0jBBgwFoAUlzkplPACB2aNTWtf9SAMLOXe4oQwDwYDVR0TAQH/
    BAUwAwEB/zANBgkqhkiG9w0BAQsFAAOCAQEAKJ+1w5PE0c2X4DJ3l4fHQcufWFiB
    peTsrc/f+bduylymB+Pxzrr7fUUFuSZcKXFaLsOUJrdhJwPhIkSWTzzlf2HK8+Ij
    SoW7PueuVsv9jHHCBhfMowqK59OzlH//naQttktKhpabro7yD8lMtem7yrUZg/KE
    y8HQCSKlc0dx2VNi2Irox5X78Z6louuB3fddQ0J/gs3hxL0BkAEbmsjWBm9aM4Hr
    OCQRqcgynJoxn0oma7z1OFs0tmyQYJnS5BIzkFDk8wztJJUN005wn4uYtbmhSnvo
    OPfUHTmZ9T15J53vbKCNGe4ppoZeACtovv3sXdAH1g6q5m681wAQ6fcQPg==
    -----END CERTIFICATE-----
  '';

  services.caddy = {
    enable = true;
    virtualHosts = {

      "http://five.local".extraConfig = ''
        respond "hiiii"
      '';

      "five.five.local".extraConfig = ''
        tls /etc/self/cert.pem /etc/self/key.pem
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

  security.pki.certificateFiles = [
    # Firefox certs
    "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
  ];

  security.pki.certificates = [

    # Caddy five
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

    # Caddy pear
    ''
    -----BEGIN CERTIFICATE-----
    MIIBojCCAUmgAwIBAgIQDT3QKIFlGWYufkhhke6EOjAKBggqhkjOPQQDAjAwMS4w
    LAYDVQQDEyVDYWRkeSBMb2NhbCBBdXRob3JpdHkgLSAyMDIzIEVDQyBSb290MB4X
    DTIzMTAxMTE5NTA0NFoXDTMzMDgxOTE5NTA0NFowMDEuMCwGA1UEAxMlQ2FkZHkg
    TG9jYWwgQXV0aG9yaXR5IC0gMjAyMyBFQ0MgUm9vdDBZMBMGByqGSM49AgEGCCqG
    SM49AwEHA0IABFB/DMlaGLTqTGa6qGZr4U+rHg+j4jXzUkDChGZpY+soPGU8grU3
    bsQ5xPfwO2p6aJx2tkRV6qXwQMIftvnl3M6jRTBDMA4GA1UdDwEB/wQEAwIBBjAS
    BgNVHRMBAf8ECDAGAQH/AgEBMB0GA1UdDgQWBBSp7OvqGNig/dzvLkIb0e++m+vr
    6zAKBggqhkjOPQQDAgNHADBEAiBp9VoNSi2+mFhrGpZbYirapfwl+vExP4JvKgpF
    YSYCLgIge0hmE2sXLGY44Cma/fDQNkJw+iXg2txnrguXLky+PhQ=
    -----END CERTIFICATE-----
    ''

    # Self-signed
    (config.environment.etc."/self/cert.pem".text)
  ];

  networking.firewall.allowedTCPPorts = [ 80 443 8000 ];

  networking.extraHosts = ''
    127.0.0.1 docs.five.local spar.five.local
    127.0.0.1 ok.five.local five.five.local
    192.168.0.42 cache.pear.local docs.pear.local ok.pear.local pear.local
    192.168.0.42 grafana.pear.local prometheus.pear.local webhook.pear.local
    192.168.0.42 ollama.pear.local
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

}

