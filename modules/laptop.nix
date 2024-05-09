{

  services.tlp = {
    enable = true;
    settings = {
      # CPU_SCALING_GOVERNOR_ON_AC = "performance";
      # CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      # CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      # CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      # CPU_BOOST_ON_BAT = 0;
      # RUNTIME_PM_ON_BAT = "auto";
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 100;
      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  powerManagement = {
    powertop.enable = true;
    enable = true;
    resumeCommands = ''
      echo "Resumed"
    '';
  };

  services.thermald.enable = true;
  services.upower.enable = true;

}
