{ pkgs, ... }:

# https://github.com/NeshHari/XMonad
# https://xmonad.org/TUTORIAL.html
# https://wiki.archlinux.org/title/Xmonad
# https://archives.haskell.org/projects.haskell.org/xmobar/

{

  location.provider = "geoclue2";
  services.geoclue2.enable = true;
  services.redshift.enable = true;

  environment.systemPackages = with pkgs; [
    xorg.xset
    dunst
    xbindkeys
    xmobar
    alacritty
    scrot
    flameshot
    feh
    dunst
    libnotify
    dmenu
    pw-volume
    jq
    rofi
  ];

  # Hide cursor after 10s
  services.unclutter = {
    enable = true;
    timeout = 10;
  };

  # Run `xset q` to see current state
  environment.etc."X11/xinit/xinitrc".text = ''
    xset -b # disable bell
    xset s 120 # screensaver after 120s
    exec xmonad
  '';

  environment.etc."alacritty.yaml".text = ''
    font:
      size: 8.0

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

  environment.variables = {
    TERMINAL = "alacritty --config-file /etc/alacritty.yaml";
  };

  services.physlock = {
    enable = true;
    muteKernelMessages = true;
    allowAnyUser = true;
  };

  # To eliminate screen tearing on Intel laptops
  # Said to reduce performance, but I did not notice
  services.xserver.videoDrivers = [ "intel" ];
  services.xserver.deviceSection = ''
    Option "DRI" "2"
    Option "TearFree" "true"
    '';

  services.dbus = {
    enable = true;
    packages = [ pkgs.dconf ];
  };

  programs.dconf.enable = true;

  services.xserver = {
    enable = true;
    layout = "us";

    libinput = {
      enable = true;
      touchpad = {
        tapping = false;
        disableWhileTyping = true;
      };
    };

    xautolock = {
      enable = true;
      time = 1; # minutes
      locker = "/run/wrappers/bin/physlock";
      killtime = 10; # mins
      killer = "${pkgs.systemd}/bin/systemctl suspend";
      extraOptions = [ "-secure" "-detectsleep" ];
      enableNotifier = true;
      notify = 10; # seconds
      notifier = ''${pkgs.libnotify}/bin/notify-send "10s to lock"'';
    };

    displayManager = {
      # startx.enable = true;
      # defaultSession = "none+xmonad";
      lightdm = {
        enable = true;
        greeters.slick.enable = true;
      };
      autoLogin = {
        enable = true;
        user = "kon";
      };
    };

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = let

        xmobarConfig = pkgs.writeScript "xmobarrc"
        ''
        Config { template = "%XMonadLog% }{ %locks% %diskio% %disku% %memory% %dynnetwork% %brightness% %battery% %date%"
        , font = "Terminus 10px"
        , bgColor = "black"
        , fgColor = "white"
        , position = Top
        , pickBroadest = True
        , commands =
        [ Run XMonadLog
        , Run Locks
        , Run DiskIO [("/", "<read><fc=gray>/</fc><write>")] [ "-L", "100", "-H", "3000", "-l", "grey", "-h", "yellow", "-n", "orange" ] 10
        , Run DiskU [("/", "<free>")] [ "-L", "400", "-l", "red" ] 10
        , Run Memory ["-t", "<usedratio>%", "-L", "20", "-H", "90", "-h", "red", "-n", "orange"] 10
        , Run DynNetwork ["-t", "<dev> <rx><fc=gray>/</fc><tx>", "-L", "500", "-H", "5000", "-l", "gray", "-h", "yellow", "-n", "orange"] 10
        , Run Com "light" [ "-r" ] "brightness" 50
        , Run Battery ["-t", "<left>%", "-L", "20", "-H", "80", "-l", "red", "-h", "green", "-n", "pink"] 10
        , Run Date "%F %a %T" "date" 10
        ] }
        '';

      in

        # 1 2 [3] 4 : Tall : [xmonad.nix] [XMonad.Hoo] ... CAPS 0K/0K 409G 10% wlp3s0 0/0 1212 36% 2024-04-15 Mon 00:26:43
        ''
        import Data.Tree
        import XMonad
        import XMonad.Config.Desktop
        import XMonad.Util.EZConfig
        import XMonad.Util.Ungrab
        import XMonad.Util.EZConfig (additionalKeysP)
        import XMonad.Hooks.DynamicLog
        import XMonad.Hooks.StatusBar
        import XMonad.Hooks.StatusBar.PP
        import XMonad.Util.Loggers
        import XMonad.Hooks.ManageHelpers
        import XMonad.Hooks.ScreenCorners
        import XMonad.Hooks.WindowSwallowing
        import XMonad.Actions.WindowMenu
        import XMonad.Actions.GridSelect
        import XMonad.Actions.TreeSelect
        import XMonad.Hooks.WorkspaceHistory
        import qualified XMonad.StackSet as W
        import XMonad.Util.SpawnOnce

        configuration = def
          { terminal = "alacritty --config-file /etc/alacritty.yaml"
          , modMask = mod4Mask
          , borderWidth = 0
          , manageHook = manageHook'
          , startupHook = startupHook'
          , handleEventHook = swallowHook'
          }
          `additionalKeysP`
          [ ("M-f", spawn "firefox")
          , ("M-p", spawn "rofi -show run")
          , ("S-M-l", spawn "physlock")
          , ("S-M-<Backspace>", kill)
          , ("M-n", spawn "notify-send hi")
          , ("M-m", windowMenu)
          , ("M-g", goToSelected def)
          , ("<Print>", spawn "flameshot gui")
          , ("<XF86MonBrightnessUp>", spawn "light -A 10")
          , ("<XF86MonBrightnessDown>", spawn "light -U 10")
          , ("<XF86AudioRaiseVolume>", spawn "pw-volume change +1%")
          , ("<XF86AudioLowerVolume>", spawn "pw-volume change -1%")
          , ("<XF86AudioMute>", spawn "pw-volume mute toggle")
          , ("<XF86Favorites>", spawn "notify-send '*'")
          ]

        startupHook' = do
          spawnOnce "notify-send 'spawned.'"

        swallowHook' = swallowEventHook
          (className =? "Alacritty") (return True)

        manageHook' = composeAll
          [ className =? ".arandr-wrapped" --> doFloat
          , isDialog                       --> doCenterFloat
          ]

        -- Define some colors for xmobar
        magenta  = xmobarColor "#ff79c6" ""
        blue     = xmobarColor "#bd93f9" ""
        white    = xmobarColor "#f8f8f2" ""
        yellow   = xmobarColor "#f1fa8c" ""
        red      = xmobarColor "#ff5555" ""
        grey     = xmobarColor "#bbbbbb" ""

        windowTitles = logTitles formatFocused formatUnfocused
        formatFocused = yellow . wrap "[" "]" . ppWindow
        formatUnfocused = white . wrap "[" "]" . ppWindow
        ppWindow = xmobarRaw
          . (\w -> if null w then "?" else w)
          . trim . shorten' "" 10

        -- https://xmonad.github.io/xmonad-docs/xmonad-contrib/XMonad-Hooks-DynamicLog.html#t:PP
        pretty = def {
            ppOrder = \[ws, layout, _, wins] -> [ws, layout, wins]
          , ppCurrent = yellow . wrap "[" "]"
          , ppUrgent = red . wrap (yellow "!") (yellow "!")
          , ppExtras = [ windowTitles ]
          }

        -- C-b to toggle xmobar ("struts"), but why here?
        strutsKey XConfig { modMask = m } = (m, xK_b)

        main = xmonad
          $ withEasySB (statusBarProp "xmobar ${xmobarConfig}" (pure pretty)) strutsKey
          $ configuration
        '';
    };
  };

}

