{
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        # A2DP sink
        Enable = "Source,Sink,Media,Socket";
        # Battery level
        Experimental = true;
      };
    };
  };
  services.blueman.enable = true;
}
