{ config, pkgs, ... } @ self:

# https://github.com/DeterminateSystems/nix-installer
# nix run nix-darwin switch --flake .#moth
# darwin-rebuild build --flake .#moth
# https://daiderd.com/nix-darwin/manual/index.html

{
  environment.systemPackages = with pkgs; [
    neovim
    htop
    jq
    ripgrep
    git
    curl
    alacritty
    keepassxc

    utm # virtual machines
    m-cli # macos management
    iina # video player
    skimpdf # pdf reader
    shortcat # shortcuts

    # bartender # menu bar
    # rectangle # window manager
  ];

  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";

    taps = [];
    brews = [ "cowsay" ];
    casks = [];
  };


  security.pam.enableSudoTouchIdAuth = true;

  system.stateVersion = 4;

  fonts.packages = [
    pkgs.monaspace
  ];


  networking.hostName = "moth";
  networking.computerName = "moth";

  services.tailscale.enable = true;

  nix = {
    settings.experimental-features = "nix-command flakes";
    package = pkgs.nix;
  };

  nix.settings.trusted-public-keys = [ "cache.daiderd.com-1:R8KOWZ8lDaLojqD+v9dzXAqGn29gEzPTTbr/GIpCTrI=" ];
  nix.settings.trusted-substituters = [ "https://d3i7ezr9vxxsfy.cloudfront.net" ];
  nix.settings.sandbox = true;
  nix.settings.extra-sandbox-paths = [ "/private/tmp" "/private/var/tmp" "/usr/bin/env" ];

  services.skhd.enable = true;
  services.nix-daemon.enable = true;
  programs.zsh.enable = true;

  environment.loginShell = "${pkgs.zsh}/bin/zsh -l";
  environment.variables.SHELL = "${pkgs.zsh}/bin/zsh";
  environment.variables.LANG = "en_US.UTF-8";

  system.configurationRevision = self.rev or self.dirtyRev or null;

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

  system.defaults = {
    dock = {
      autohide = true;
      mru-spaces = false;
      orientation = "left";
      showhidden = true;
    };

    finder = {
      AppleShowAllExtensions = true;
      QuitMenuItem = true;
      FXEnableExtensionChangeWarning = false;
    };

    trackpad = {
      Clicking = true;
      TrackpadThreeFingerDrag = true;
    };

    NSGlobalDomain = {
      AppleKeyboardUIMode = 3;
      ApplePressAndHoldEnabled = false;

      "com.apple.swipescrolldirection" = false;
      "com.apple.mouse.tapBehavior" = 1;
      "com.apple.sound.beep.volume" = 0.0;
      "com.apple.sound.beep.feedback" = 0;

      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticInlinePredictionEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
      _HIHideMenuBar = true;
    };

  };


}

