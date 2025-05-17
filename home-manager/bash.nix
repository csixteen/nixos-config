{ config, lib, pkgs, ... }:

{
  programs.bash = {
    enable = true;

    enableCompletion = true;

    historyControl = [ "ignoredups" ];
    historyFileSize = 100000;
    historyIgnore = ["&" "[ ]*" "exit" "ls" "bg" "fg" "history" "clear"];
    historySize = 100000;

    sessionVariables = {
      COLORTERM = "24bit";
      TERM = "xterm-256color";
      GROFF_NO_SGR = "1";

      EDITOR = "vim";

      LESS_TERMCAP_mb = "$'\E[01;31m'";                             # begin blinking
      LESS_TERMCAP_md = "$'\E[01;38;5;74m'";                        # begin bold
      LESS_TERMCAP_me = "$'\E[0m'";                                 # end mode
      LESS_TERMCAP_se = "$(tput rmso; tput sgr0)";                  # end standout-mode
      LESS_TERMCAP_so = "$(tput bold; tput setaf 6; tput setab 0)"; # begin standout-mode - info box
      LESS_TERMCAP_ue = "$'\E[0m'";                                 # end underline
      LESS_TERMCAP_us = "$'\E[04;38;5;146m'";                       # begin underline
      LESS = "-R";                                                  # don't clear the screen on exit

      MANROFFOPT = "-c";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    };

    shellOptions = [
      "histappend"
      "cmdhist"
    ];

    bashrcExtra = ''
      function exists {
          command -v "$1" &> /dev/null
      }

      for file in ~/.{paths,functions,aliases,shell_prompt}.sh; do
          [ -r "$file" ] && source "$file"
      done
      unset file

      if [[ -e ~/.bashrc.local ]]; then
          . ~/.bashrc.local
      fi
    '';
  };
}
