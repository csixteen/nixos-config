{ lib, pkgs, ... }:

{
  boot = lib.mkMerge [{
    kernelParams = [
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
    HandleLidSwitch = "suspend-then-hibernate";
    # When connected to power simply locks screen
    HandleLidSwitchExternalPower = "suspend-then-hibernate";
    # When another screen is connected, ignore
    HandleLidSwitchDocked = "ignore";
  };

  services.power-profiles-daemon.enable = true;

  # Automatically switch to power-saver on battery and balanced on AC
  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="0", RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver"
    SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="1", RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced"
  '';

  systemd.sleep.settings.Sleep = {
    HibernateDelaySec = "5min";
    HibernateOnACPower = true;
  };
}
