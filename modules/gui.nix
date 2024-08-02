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
    kdenlive # video editing
    audacity # audio editing
    mpv
    vlc
    peek # record gif/webm of a window
    inkscape
    openscad
    xournal # draw (including on pdfs)
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
  ];
}
