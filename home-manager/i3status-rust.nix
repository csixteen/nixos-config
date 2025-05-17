{ config, lib, pkgs, ... }:

{
  programs.i3status-rust = {
    enable = true;

    bars = {
      top = {
        blocks = [
          {
            block = "net";
            format = " $icon $ip ($ssid $signal_strength / $device) ^icon_net_down $speed_down.eng(prefix:K) ^icon_net_up $speed_up.eng(prefix:K) ";
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
          }
          {
            block = "cpu";
            interval = 1;
          }
          {
            block = "load";
            format = " $icon $1m ";
            interval = 1;
          }
          {
            block = "sound";
          }
          {
            block = "time";
            interval = 60;
            format = " $timestamp.datetime(f:'%a %d/%m/%y %R') ";
          }
          {
            block = "battery";
            format = " $percentage /$power $icon ";
            full_format = " $percentage $icon ";
          }
        ];

        settings = {
          theme = {
            theme = "gruvbox-dark";
          };
        };
        icons = "awesome6";
        theme = "gruvbox-dark";
      };
    };
  };
}
