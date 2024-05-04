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
    ../../modules/cursor.nix
    ../../modules/ssd.nix
    ../../modules/cli.nix
    ../../modules/hi.nix
    ../../modules/options/user.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  user.name = "kon";

  time.timeZone = "Europe/London";
  networking.hostName = "twelve";

  users.motd = ''
         ______________
        ||            ||
        ||            ||
        ||    12      ||
        ||            ||
        ||____________||     _ Twelve _
        |______________|   /           )
         \ ############ \ /           /
          \ ##:)######## \        =D-'
           \      ____    \
            \_____\___\____\

  '';

  nixpkgs.config.allowUnfree = true;
  system.nixos.label = "baroque";
  system.configurationRevision = self.rev or self.dirtyRev or "none";
  system.stateVersion = "23.11";

}

