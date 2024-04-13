{
  services.avahi = {
    enable = false;
    nssmdns = true;
    reflector = true;
    publish = {
      enable = true;
      domain = true;
      addresses = true;
      workstation = true;
      userServices = true;
    };
  };
}
