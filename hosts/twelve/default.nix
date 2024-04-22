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
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  time.timeZone = "Europe/London";
  networking.hostName = "twelve";
  services.getty.autologinUser = "kon";

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

  ];

  # services.tailscale.enable = true;
  # services.dnsmasq.enable = true;

  services.tlp = {
    enable = true;
    # TODO: find performance/battery balance
    # settings = {
    #   STOP_CHARGE_THRESH_BAT0 = 90;
    #   CPU_SCALING_GOVERNOR_ON_BATTERY = "powersave";
    #   CPU_BOOST_ON_BAT = 0;
    #   RUNTIME_PM_ON_BAT = "auto";
    # };
  };
  services.thermald.enable = true;
  powerManagement.powertop.enable = true;
  services.autorandr.enable = true;
  services.upower.enable = true;
  services.devmon.enable = true;
  programs.light.enable = true;
  services.picom.enable = true;
  powerManagement.enable = true;

  nixpkgs.config.allowUnfree = true;
  system.nixos.label = "baroque";
  system.configurationRevision = self.rev or self.dirtyRev or "none";
  system.stateVersion = "23.11";

}

