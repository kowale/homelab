{
  services.picom = {
    enable = true;
    vSync = true;
    inactiveOpacity = 0.95;
    fadeExclude = [
      "window_type *= 'menu'"
      "focused = 1"
    ];
  };
}
