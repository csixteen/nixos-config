{ config, lib, pkgs, ... }:

let
  mod = "Mod4";
  lock_cmd = "${pkgs.i3lock}/bin/i3lock";
in {
  # Automatically lock on lid-close/suspend and after 5 minutes of inactivity
  services.screen-locker = {
    enable = true;

    lockCmd = "${pkgs.i3lock}/bin/i3lock -n -c 000000";
    inactiveInterval = 5;  # minutes
    xautolock = {
      enable = true;

      extraOptions = [
        "-time" "5"
        "-locker" "${pkgs.i3lock}/bin/i3lock -c 000000"
        "-killtime" "15"
        "-killer" "systemctl suspend"
      ];
    };
  };

  xsession.enable = true;
  xsession.windowManager.i3 = {
    enable = true;

    config = {
      bars = [
        {
          colors = {
            focusedWorkspace = { background = "#555555"; border = "#5a5a5a"; text = "#ffffff"; };
          };

          fonts = {
            names = ["Iosevka"];
            style = "Bold Semi-Condensed";
            size = 9.0;
          };
          position = "top";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-top.toml";
        }
      ];

      colors = {
        focused = {
          background = "#2a2a2a";
          border = "#2a2a2a";
          childBorder = "#2a2a2a";
          text = "#ffffff";
          indicator = "#2a2a2a";
        };

        unfocused = {
          background = "#1a1a1a";
          border = "#1a1a1a";
          childBorder = "#1a1a1a";
          text = "#aaaaaa";
          indicator = "#1a1a1a";
        };
      };

      defaultWorkspace = "workspace number 1";

      focus = {
        followMouse = false;
      };

      fonts = {
        names = ["Iosevka"];
        style = "Regular";
        size = 10.0;
      };

      keybindings = lib.mkOptionDefault {
        "${mod}+Shift+e" = "exit";
        "${mod}+Shift+l" = "exec ${lock_cmd} -c 000000";
        "${mod}+Tab" = "workspace next";
        "${mod}+Shift+Tab" = "workspace prev";
        "${mod}+p" = "exec ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set powersaver";
        "${mod}+Shift+p" = "exec ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance";

        # Screenshot key bindings
        ## Full screen
        "Print" = "exec ${pkgs.scrot}/bin/scrot -q 100 $HOME/Pictures/Screenshots/%Y-%m-%d_%H%M%S_$w$h.png";
        ## Selection
        "${mod}+Print" = "exec ${pkgs.scrot}/bin/scrot -q 100 -s $HOME/Pictures/Screenshots/%Y-%m-%d_%H%M%S_$w$h.png";
        ## Currently focused window
        "Shift+Print" = "exec ${pkgs.scrot}/bin/scrot -q 100 -u $HOME/Pictures/Screenshots/%Y-%m-%d_%H%M%S_$w$h.png";

        # Audio key bindings
        "XF86AudioRaiseVolume" = "exec ${pkgs.pamixer}/bin/pamixer -i 1";
        "XF86AudioLowerVolume" = "exec ${pkgs.pamixer}/bin/pamixer -d 1";
        "XF86AudioMute" = "exec ${pkgs.pamixer}/bin/pamixer -t";
      };

      menu = "rofi -show drun";
      modifier = mod;

      startup = [
        { command = "exec --no-startup-id ${pkgs.feh}/bin/feh --bg-scale /home/pmpro/Pictures/wallpaper.png"; always = true; notification = false; }
        { command = "exec --no-startup-id xset r rate 200 60"; }
        { command = "exec --no-startup-id xset s 300 300 && xset dpms 300 300 300"; }
      ];

      terminal = "alacritty";
      window = {
        hideEdgeBorders = "vertical";
      };
      workspaceAutoBackAndForth = true;
    };
  };
}
