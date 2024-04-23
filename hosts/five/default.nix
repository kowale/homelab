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
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  time.timeZone = "Europe/London";
  networking.hostName = "five";
  services.getty.autologinUser = "kon";
  services.tailscale.enable = true;

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
       / /==============\ \
      /____________________\
      \____________________/

  '';

  age.secrets.hello.file = ../../secrets/hello.age;

  environment.variables = {
    TERM = "linux";
    EDITOR = "nvim";
    HI = config.age.secrets.hello.path;
  };

  environment.systemPackages = with pkgs; [
    (callPackage ../../pkgs/nvim {})
    htop
    ripgrep
    fd
    sd
    bat
    fzf
    jq
    htmlq
    nq
    btop
    bmon
    usbtop
    psmisc
    sysstat
    hdparm
    ncdu
    iotop
    lm_sensors
    lsof
    wavemon
    chromium
    smartmontools
    qrcp
    ranger
    tmux
    pciutils
    binutils
    acpi
    rofi
    xclip
    xsel
    python3
  ];

  services.autorandr.enable = true;
  services.devmon.enable = true;
  programs.light.enable = true;

  nixpkgs.config.allowUnfree = true;
  system.configurationRevision = self.rev or self.dirtyRev or "none";
  system.stateVersion = "23.11";

}

