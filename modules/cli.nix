{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    (callPackage ../pkgs/nvim {})
    htop
    ripgrep
    fd
    sd
    entr
    bat
    fzf
    jq
    htmlq
    btop
    usbtop
    psmisc
    sysstat
    hdparm
    ncdu
    iotop
    lm_sensors
    lsof
    chromium
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
    graphviz
  ];
}
