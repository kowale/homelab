{ config, pkgs, lib, ... } @ self:

{

  # TODO: move to nixosModules
  imports = [
    ./hardware.nix
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
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

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

    "I would define the baroque as that style that
    deliberately exhausts (or tries to exhaust) its
    own possibilities, and that borders on self-caricature."

    Jorge Luis Borges "A Universal History of Infamy" (1935)
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
    smartmontools
    qrcp
    ranger
    tmux
    pciutils
    binutils
    acpi
    rofi
  ];

  services.pict-rs.enable = true;
  services.autorandr.enable = true;

  services.devmon.enable = true;
  programs.light.enable = true;
  services.picom.enable = true;
  powerManagement.enable = true;

  nixpkgs.config.allowUnfree = true;
  system.nixos.label = "baroque";
  system.configurationRevision = self.rev or self.dirtyRev or "none";
  system.stateVersion = "23.11";

}

