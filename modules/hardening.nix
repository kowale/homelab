{ pkgs, ... }:

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

  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
  };

  services.fail2ban.enable = true;
  services.opensnitch.enable = true;

}
