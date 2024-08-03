{
  services.avahi = {
    enable = true;
    openFirewall = true;
    nssmdns4 = true;
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
