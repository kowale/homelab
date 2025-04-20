{ config, pkgs, lib, ... } @ self:

{

  # TODO: move to nixosModules
  imports = [
    ./hardware-configuration.nix
    ../../modules/xmonad.nix
    ../../modules/picom.nix
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
    #../../modules/hardening.nix
    ../../modules/laptop.nix
    ../../modules/tailscale.nix
    ../../modules/cursor.nix
    ../../modules/ssd.nix
    ../../modules/cli.nix
    ../../modules/gui.nix
    ../../modules/nats.nix
    # ../../modules/monitoring.nix
    ../../modules/restic.nix
    ../../modules/options/user.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.luks.devices."luks-697269ec-96f1-4f81-9a51-65cc2e6b8f08".device = "/dev/disk/by-uuid/697269ec-96f1-4f81-9a51-65cc2e6b8f08";

  boot.kernelParams = [
    "acpi.ec_no_wakeup=1" # https://bbs.archlinux.org/viewtopic.php?id=298895
  ];

  user.name = "kon";
  time.timeZone = "Europe/London";

  system.configurationRevision = self.rev or self.dirtyRev or "none";
  environment.enableDebugInfo = true;
  networking.hostName = "six";

  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

  users.users.kon = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.05";

  services.fwupd.enable = true;

  programs.direnv = {
    enable = true;
    loadInNixShell = true;
  };

}
