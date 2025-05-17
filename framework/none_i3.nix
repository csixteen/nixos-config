{ lib, config, pkgs, ... }:

{
  imports = [
    ./X11.nix
  ];

  services.xserver = lib.mkMerge [
    {
      desktopManager = {
        xterm.enable = false;
      };

      displayManager = {
        startx.enable = true;
      };

      windowManager.i3 = {
        enable = true;

        extraPackages = with pkgs; [
          dmenu
          i3lock
          rofi
        ];
      };
    }
  ];
 
  services.displayManager = {
    enable = true;

    defaultSession = "none+i3";
  };
}
