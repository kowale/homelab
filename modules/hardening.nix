{ pkgs, ... }:

# https://tiiuae.github.io/ghaf/architecture/architecture.html
# https://github.com/tiiuae/sbomnix
# https://spectrum-os.org/doc/
# https://nixos.wiki/wiki/Security
# https://wiki.nixos.org/wiki/Systemd/Hardening
# https://dataswamp.org/~solene/2022-01-13-nixos-hardened.html
# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/profiles/hardened.nix
# https://xeiaso.net/blog/paranoid-nixos-2021-07-18/

{
  systemd.coredump.enable = false;

  security = {
    chromiumSuidSandbox.enable = true;
    auditd.enable = true;
    audit.enable = true;
    audit.rules = [
      "-a exit,always -F arch=b64 -S execve"
    ];
    sudo.execWheelOnly = true;
  };

  # TODO: `opensnitch-ui` to start a session
  services.opensnitch.enable = true;

  environment.etc."/clamav/onVirus" = {
    text = ''
      ALERT="$CLAM_VIRUSEVENT_VIRUSNAME in $CLAM_VIRUSEVENT_FILENAME"
      notify-send -u critical "$ALERT"
    '';
    mode = "0777";
  };

  # `sudo freshclam` to update virus database
  # `curl https://secure.eicar.org/eicar.com.txt | clamscan` to test
  services.clamav = {
    updater.enable = true;
    daemon = {
      enable = true;
      settings = {
        OnAccessMountPath = "/home/kon/other/downloads";
        OnAccessPrevention = false;
        OnAccessExtraScanning = true;
        OnAccessExcludeUname =  "clamav";
        VirusEvent = "/etc/clamav/onVirus";
        User = "clamav";
      };
    };
  };

  services.fail2ban = {
    enable = true;
    maxretry = 10;
    bantime = "30m";
    ignoreIP = [ "127.0.0.1/16" "192.168.1.0/24" ];
  };

  # vulnix --system -vv
  # firejail, apparmor, selinux

}
