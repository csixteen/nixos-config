{ config, lib, pkgs, ... }:

let
  package = pkgs.gitAndTools.git;
in
{
  programs.git = {
    inherit package;

    enable = true;

    userName = "Pedro Rodrigues";
    userEmail = "csixteen@protonmail.com";

    aliases = {
      cm = "commit -am";
      cnt = "rev-list --all --count";
      co = "checkout";
      d = "diff";
      dv = "difftool -t vimdiff -y";
      last = "log -1 HEAD --stat";
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --";
      ll = "log --oneline";
      p = "push -u origin HEAD";
      pl = "pull";
      rv = "remote -v";
      s = "status -sb";
      se = "!git rev-list --all | xargs git grep -n --full-name -F";
      undocommit = "reset HEAD~";
      undopush = "push -f origin HEAD^:main";
    };

    extraConfig = {
      color = {
        "branch" = {
          current = "yellow reverse";
          local = "yellow";
          remote = "green";
        };

        "diff" = {
          commit = "green bold";
          frag = "magenta bold";
          meta = "yellow bold";
          old = "red bold";
        };

        "status" = {
          added = "yellow";
          changed = "green";
          untracked = "cyan";
        };
      };

      core = {
        attributesfile = "~/.gitattributes";
        editor = "vim";
        excludesfile = "~/.gitignore";
      };

      fetch = {
        prune = true;
      };

      log = {
        date = "relative";
      };

      pull = {
        rebase = false;
      };

      push = {
        followTags = true;
      };
    };
  };
}
