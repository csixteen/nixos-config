{ lib, ... }:

{
  boot = lib.mkMerge [{
    kernelParams = [
      "acpi.ec_no_wakeup=1"
      "acpi_osi=\"!Windows 2020\""
      "amd_pstate=active"
      "mem_sleep_default=s2idle"
      # This is disabled because it may drain battery. This flag prevents the
      # kernel from using ACPI power states (D3cold / APST) on NVMe drives.
      # Without it, the SSD cannot enter its "deepest" sleep state during idle
      # or s2idle standby, which causes significant drain.
      #"nvme.noacpi=1"
      "rtc_cmos.use_acpi_alarm=1"
    ];
  }];

  # Disable light sensors and accelerometers, as
  # they are not used and consume extra battery
  hardware.sensor.iio.enable = false;

  services.logind.settings.Login = {
    # Normal behavior
    HandleLidSwitch = "suspend";
    # When connected to power simply locks screen
    HandleLidSwitchExternalPower = "suspend";
    # When another screen is connected, ignore
    HandleLidSwitchDocked = "ignore";
  };

  services.power-profiles-daemon.enable = true;
}
