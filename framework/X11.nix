{ config, pkgs, ... }:

{
  environment.variables = {
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    XCURSOR_SIZE = "64";
  };

  services.libinput = {
    enable = true;

    touchpad = {
      accelSpeed = "0.5";
      clickMethod = "clickfinger";
      horizontalScrolling = true;
      naturalScrolling = true;
      tapping = false;
    };
  };

  services.xserver = {
    enable = true;

    dpi = 180;

    displayManager = {
      importedVariables = [
        "GDK_SCALE"
        "GDK_DPI_SCALE"
        "QT_AUTO_SCREEN_SCALE_FACTOR"
      ];
    };

    upscaleDefaultCursor = true;
    videoDrivers = [ "amdgpu" ];

    xkb = {
      layout = "us";
      variant = "";
      options = "terminate:ctrl_alt_bksp,ctrl:nocaps";
    };
  };
 
  # If settings aren't being saved for some applications (gtk3 applications,
  # firefox, etc), like the size of file selection windows, or the size of
  # the save dialog, we need to enable dconf.
  programs.dconf.enable = true;
}
