{ lib, ... }:

{
  boot = lib.mkMerge [{
    kernelParams = [
      "acpi.ec_no_wakeup=1"
      "acpi_osi=\"!Windows 2020\""
      "amd_pstate=active"
      "mem_sleep_default=s2idle"
      "nvme.noacpi=1"
      "rtc_cmos.use_acpi_alarm=1"
    ];
  }];

  # Disable light sensors and accelerometers, as
  # they are not used and consume extra battery
  hardware.sensor.iio.enable = false;

  services.logind = {
    # Normal behavior
    lidSwitch = "suspend";
    # When connected to power simply locks screen
    lidSwitchExternalPower = "suspend";
    # When another screen is connected, ignore
    lidSwitchDocked = "ignore";
  };

  services.power-profiles-daemon.enable = true;
}
