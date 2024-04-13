{ pkgs, ... }:

# https://github.com/NeshHari/XMonad
# https://xmonad.org/TUTORIAL.html
# https://wiki.archlinux.org/title/Xmonad
# https://archives.haskell.org/projects.haskell.org/xmobar/

{

  environment.systemPackages = with pkgs; [
    xorg.xset
    dunst
    xbindkeys
    xmobar
    alacritty
    slock
    scrot
    feh
    dunst
    libnotify
    dmenu
    pw-volume
  ];

  environment.etc."X11/xinit/xinitrc".text = ''
    xset -b
    exec xmonad
  '';

  services.xserver = {
    enable = true;
    layout = "us";
    libinput.enable = true;

    displayManager = {
      startx.enable = true;
      defaultSession = "none+xmonad";
    };

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = let

        xmobarConfig = pkgs.writeScript "xmobarrc"
        ''
        Config { position = Top
        , template = "%XMonadLog% }{ %diskio% %disku% %memory% %dynnetwork% %light% %battery% %date%"
        , font = "Terminus 12px"
        , bgColor = "black"
        , fgColor = "white"
        , pickBroadest = True
        , commands =
        [ Run XMonadLog
        , Run DiskIO [("/", "<read><fc=gray>/</fc><write>")] [ "-L", "100", "-H", "3000", "-l", "grey", "-h", "yellow", "-n", "orange" ] 10
        , Run DiskU [("/", "<free>")] [ "-L", "400", "-l", "red" ] 10
        , Run Memory ["-t", "<usedratio>%", "-L", "20", "-H", "90", "-h", "red", "-n", "orange"] 10
        , Run DynNetwork ["-t", "<dev> <rx><fc=gray>/</fc><tx>", "-L", "500", "-H", "5000", "-l", "gray", "-h", "yellow", "-n", "orange"] 10
        , Run Com "light" [] "light" 10
        , Run Battery ["-t", "<left>%", "-L", "20", "-H", "80", "-l", "red", "-h", "green", "-n", "pink"] 10
        , Run Date "%F (%a) %T" "date" 10
        ] }
        '';

        alacrittyConfig = pkgs.writeText "alacritty.yml" ''
        font:
          size: 12.0

        window:
          decorations: "None"
          resize_increments: true

        colors:
          primary:
            background: "0x000000"
            foreground: "0xffffff"

        key_bindings:
            - { key: "T", mods: "Control|Shift", action: "SpawnNewInstance"}
            - { key: "Plus", mods: "Control|Shift", action: "IncreaseFontSize"}
            - { key: "Plus", mods: "Control|Shift", action: "IncreaseFontSize"}
            - { key: "Plus", mods: "Control|Shift", action: "IncreaseFontSize"}
            - { key: "Plus", mods: "Control|Shift", action: "IncreaseFontSize"}
            - { key: "Minus", mods: "Control", action: "DecreaseFontSize"}
            - { key: "Minus", mods: "Control", action: "DecreaseFontSize"}
            - { key: "Minus", mods: "Control", action: "DecreaseFontSize"}
            - { key: "Minus", mods: "Control", action: "DecreaseFontSize"}
        '';

      in

        ''
        import XMonad
        import XMonad.Config.Desktop
        import XMonad.Util.EZConfig
        import XMonad.Util.Ungrab
        import XMonad.Util.EZConfig (additionalKeysP)
        import XMonad.Hooks.DynamicLog
        import XMonad.Hooks.StatusBar
        import XMonad.Hooks.StatusBar.PP

        configuration = def
          { terminal = "alacritty --config-file ${alacrittyConfig}"
          , modMask = mod4Mask
          , borderWidth = 0
          }
          `additionalKeysP`
          [ ("M-f", spawn "firefox")
          , ("M-c", unGrab *> spawn "scrot -s")
          ]

        strutsKey XConfig { modMask = m } = (m, xK_b)
        xmobarCmd = "xmobar ${xmobarConfig}"

        main = xmonad
          $ withEasySB (statusBarProp xmobarCmd (pure def)) strutsKey
          $ configuration
        '';
    };
  };

}

