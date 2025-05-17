{ config, lib, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      bell = {
        animation = "EaseOutExpo";
        color = "0xffffff";
        duration = 0;
      };

      colors = {
        draw_bold_text_with_bright_colors = true;

        bright = {
          black = "#444b6a";
          blue = "#7da6ff";
          cyan = "#0db9d7";
          green = "#b9f27c";
          magenta = "#bb9af7";
          red = "#ff7a93";
          white = "#acb0d0";
          yellow = "#ff9e64";
        };

        cursor = {
          cursor = "#00ff00";
          text = "CellBackground";
        };

        normal = {
          black = "#32344a";
          blue = "#7aa2f7";
          cyan = "#449dab";
          green = "#9ece6a";
          magenta = "#ad8ee6";
          red = "#f7768e";
          white = "#787c99";
          yellow = "#e0af68";
        };

        primary = {
          background = "#1a1b26";
          foreground = "#a9b1d6";
        };
      };

      cursor = {
        unfocused_hollow = true;

        style = {
          blinking = "On";
          shape = "Block";
        };
      };

      debug = {
        log_level = "OFF";
        persistent_logging = false;
        print_events = false;
        render_timer = false;
      };

      env = {
        TERM = "xterm-256color";
      };

      font = {
        builtin_box_drawing = true;

        glyph_offset = {
          x = 0;
          y = 0;
        };

        bold = {
          family = "Iosevka";
          style = "Medium";
        };

        italic = {
          family = "Iosevka";
          style = "Light Italic";
        };

        normal = {
          family = "Iosevka";
          style = "Regular";
        };

        size = 8;
      };

      hints = {
        enabled = [{
          command = "xdg-open";
          hyperlinks = true;
          post_processing = true;
          regex = "(ipfs:|ipns:|magnet:|mailto:|gemini://|gopher://|https://|http://|news:|file:|git://|ssh:|ftp://)";

          binding = {
            key = "U";
            mods = "Control|Shift";
          };

          mouse = {
            enabled = true;
            mods = "None";
          };
        }];
      };

      mouse = {
        hide_when_typing = true;

        bindings = [
          { action = "PasteSelection"; mouse = "Middle"; }
        ];
      };

      scrolling = {
        history = 10000;
        multiplier = 3;
      };

      selection = {
        save_to_clipboard = true;
        semantic_escape_chars = ",│`|:\"' ()[]{}<>";
      };

      terminal = {
        shell = {
          program = "${pkgs.tmux}/bin/tmux";
          args = [
            "-f"
            "/home/pmpro/.config/tmux/tmux.conf"
            "new-session"
            "-A"
            "-D"
            "-s"
            "main"
          ];
        };
      };

      window = {
        decorations = "full";
        dynamic_padding = false;
        dynamic_title = true;
        opacity = 1.0;

        padding = {
          x = 2;
          y = 2;
        };
      };
    };
  };
}
