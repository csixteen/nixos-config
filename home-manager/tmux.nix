{ config, lib, pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    baseIndex = 1;
    disableConfirmationPrompt = true;
    mouse = true;
    newSession = true;
    prefix = "`";
    secureSocket = false;
    sensibleOnTop = false;
    terminal = "rxvt-unicode";

    extraConfig = ''
      set-option -ga terminal-overrides ",rxvt-unicode:Tc"

      # re-number windows when one is closed
      set -g renumber-windows on

      # word separators for automatic word selection
      set -g word-separators ' @"=()[]_-:,.'
      set -ag word-separators "'"

      # tmux messages are displayed for 4 seconds
      set -g display-time 4000

      # history
      set -g history-limit 10000

      # Automatically sets window title
      set-option -g set-titles on
      set-option -g allow-rename off

      # Enable activity monitoring
      set -g monitor-activity on
      set -g visual-activity on

      # Status bar
      set -g status-right '#{prefix_highlight} | %a %Y-%m-%d %H:%M'

      #----------------------------------------
      # Key bindings

      # easy-to-remember split pane commands
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      unbind '"'
      bind %

      # moving between panes with vim movement keys
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Pressing Ctrl+Shift+Left will move the current window to the left. Similarly
      # right. No need to use the modifier (C-b)
      bind-key -n C-S-Left swap-window -t -1
      bind-key -n C-S-Right swap-window -t +1

      bind -n S-down new-window -c "#{pane_current_path}"
      bind -n S-left prev
      bind -n S-right next

      # Enter copy mode with /
      bind-key / copy-mode \; send-key ?

      # Use vim key bindings in copy mode
      setw -g mode-keys vi

      # Emacs key bindings in tmux command prompt (prefix + :) are better than
      # vi keys, even for vim users
      set -g status-keys emacs

      # Theme
      set -g @themepack 'powerline/double/cyan'

      # Plugins
      set -g @plugin 'tmux-plugins/tpm'
      set -g @plugin 'jimeh/tmux-themepack'
      set -g @plugin 'tmux-plugins/tmux-sensible'
      set -g @plugin 'tmux-plugins/tmux-prefix-highlight'
      set -g @plugin 'tmux-plugins/tmux-copycat'

      run '~/.tmux/plugins/tpm/tpm'
    '';
  };
}
