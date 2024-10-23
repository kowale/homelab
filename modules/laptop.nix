{

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      # CPU_BOOST_ON_BAT = 0;
      # RUNTIME_PM_ON_BAT = "auto";
      # CPU_MIN_PERF_ON_AC = 0;
      # CPU_MAX_PERF_ON_AC = 100;
      # CPU_MIN_PERF_ON_BAT = 0;
      # CPU_MAX_PERF_ON_BAT = 100;
      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };


  security.protectKernelImage = false;

  # services.upower.enable = true;

  # powerManagement = {
  #   enable = true;
  #   powertop.enable = true;
  # };

  services.thermald = {
    enable = true;
    ignoreCpuidCheck = true; # --ignore-cpuid-check
  };

  # TODO: seems to cause freeze sometimes, to be investigated
  # Disable wakeups (interrupts, disturabnces) on first 4 cores
  # https://www.kernel.org/doc/html/latest/timers/no_hz.html
  # boot.kernelParams = [
  #   "nohz_full=1,2,3,4"
  #   "isolcpus=1,2,3,4"
  # ];

}
