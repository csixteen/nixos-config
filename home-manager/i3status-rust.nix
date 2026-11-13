{ config, pkgs, ... }:

{
  programs.i3status-rust = {
    enable = true;

    bars = {
      top = {
        blocks = [
          {
            block = "net";
            format = " $icon $ip ($ssid $signal_strength $bitrate / $device) ^icon_net_down $speed_down.eng(prefix:K) ^icon_net_up $speed_up.eng(prefix:K) ";
            interval = 5;
          }
          {
            alert = 10.0;
            block = "disk_space";
            info_type = "available";
            interval = 60;
            path = "/";
            warning = 20.0;
          }
          {
            block = "memory";
            interval = 5;
          }
          {
            block = "cpu";
            interval = 5;
          }
          {
            block = "load";
            format = " $icon $1m ";
            interval = 5;
          }
          {
            block = "sound";
          }
          {
            block = "time";
            interval = 30;
            format = " $timestamp.datetime(f:'%a %d/%m/%y %R') ";
          }
          {
            block = "battery";
            interval = 10;
            format = " $percentage /$power $icon ";
            full_format = " $percentage $icon ";
          }
        ];

        settings = {
          theme = {
            theme = "ctp-mocha";
          };
        };
        icons = "material-nf";
        theme = "ctp-mocha";
      };
    };
  };
}
