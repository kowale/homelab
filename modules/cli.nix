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
    qrcp
    ranger
    tmux
    pciutils
    binutils
    acpi
    python3
    graphviz
    speedtest-rs
    tree
    wget
    zip
    gh
    iftop
    iperf2
    elinks
    pmacct
    dogdns
    nethogs
  ];
}
