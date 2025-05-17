{ lib, config, pkgs, ... }:

{
  services.acpid = {
    enable = true;

    handlers = {
      brightness-down = {
        event = "video/brightnessdown.*"; 
        action = ''
          #!/bin/sh
          bl_device=/sys/class/backlight/amdgpu_bl1/brightness
          echo $(($(cat $bl_device)-10)) | tee $bl_device
        ''; 
      };
      brightness-up = {
        event = "video/brightnessup.*"; 
        action = ''
          #!/bin/sh
          bl_device=/sys/class/backlight/amdgpu_bl1/brightness
          echo $(($(cat $bl_device)+10)) | tee $bl_device
        ''; 
      };
    };
  };
}
