{ config, lib, pkgs, ... }:

let
  mod = "Mod4";
  lock_cmd = "${pkgs.i3lock}/bin/i3lock";
in {
  services.picom = {
    enable = true;

    backend = "glx";
  };

  xsession.windowManager.i3 = {
    enable = true;

    config = {
      bars = [
        {
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
        "XF86AudioRaiseVolume" = "exec ${pkgs.pamixer}/bin/pamixer -i 1";
        "XF86AudioLowerVolume" = "exec ${pkgs.pamixer}/bin/pamixer -d 1";
        "XF86AudioMute" = "exec ${pkgs.pamixer}/bin/pamixer -t";
      };

      menu = "rofi -show drun -theme solarized_alternate";
      modifier = mod;

      startup = [
        { command = "exec --no-startup-id ${pkgs.feh}/bin/feh --bg-scale /home/pmpro/Pictures/wallpaper.png"; always = true; notification = false; }
        { command = "exec --no-startup-id xset r rate 262 57"; }
      ];

      terminal = "alacritty";
      window = {
        hideEdgeBorders = "vertical";
      };
      workspaceAutoBackAndForth = true;
    };
  };
}
