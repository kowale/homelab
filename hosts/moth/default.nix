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
    darwin-zsh-completions
    utm # virtual machines
    m-cli # macos management
    iina # video player
    skimpdf # pdf reader
    shortcat # shortcuts

    # bartender # menu bar
    # rectangle # window manager
  ];

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

  nixpkgs.hostplatform = "x86_64-darwin";
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
      InitialKeyRepeat = 10;
      KeyRepeat = 1;
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

