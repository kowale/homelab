{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    chromium
    xclip
    xsel
    rofi
    feh
    nomacs # advanced image viewer
    video-trimmer # trim video without transcoding
    identity # synced scroll of images
    audacity # audio editing
    mpv
    vlc
    peek # record gif/webm of a window
    inkscape
    openscad
    wireshark
    xorg.xev
    vokoscreen # record screen
    zeal # offline API docs
    xfce.thunar
    zotero
    zathura
    pdfarranger
    pdfgrep
    qpdf
    signal-desktop
    obs-studio
    pavucontrol
    ffmpeg-full
    sqlitebrowser
  ];
}
