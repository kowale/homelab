{ lib, pkgs, ... }:

{
  programs.niri.enable = true;
  programs.waybar.enable = true;

  environment.etc = {
    "niri/config.kdl".source = ./config.kdl;
    "xdg/waybar/config.jsonc".source = ./config.jsonc;
    "xdg/waybar/style.css".source = ./style.css;
    "alacritty.toml".source = ./alacritty.toml;
  };

  environment.variables = {
    TERMINAL = "alacritty --config-file /etc/alacritty.toml";
  };

  # for electron/chromium
  # https://wiki.nixos.org/wiki/Wayland
  # https://wiki.nixos.org/wiki/Niri
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    GDK_BACKEND = "wayland";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  hardware.graphics.enable = true;

  environment.systemPackages = with pkgs; [
    niri
    xwayland-satellite
    alacritty
    fuzzel
    waybar
    wl-screenrec
    wl-kbptr
    wl-clipboard-rs
    brightnessctl
    mako
    swaylock
    swayidle
    sway-audio-idle-inhibit
    sunsetr
    ghostty
  ];

  security.pam.services.swaylock = {};
  services.gnome.gnome-keyring.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "niri-session";
        user = "kon";
      };
      default_session = {
        command = "niri-session";
        user = "kon";
      };
    };
  };

  # https://github.com/ctknightdev/nixos/blob/801c7d166d6af94543d3ca7d8638e7a3cb775b16/system/greeter/greetd.nix
  systemd.settings.Manager.DefaultTimeoutStopSec = "10s";
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  # conflict with niri
  programs.ssh.startAgent = lib.mkForce false;

  # to test in qemu vm
  # nix build .#nixosConfigurations.six.config.system.build.vm
  # ./result/bin/run-six-vm -device virtio-vga-gl -display gtk,gl=on
}
