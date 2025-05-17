{ config, pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./bash.nix
    ./direnv.nix
    ./firefox.nix
    ./git.nix
    ./helix.nix
    ./i3.nix
    ./i3status-rust.nix
    ./ranger.nix
    ./ssh.nix
    ./tmux.nix
  ];

  home.username = "pmpro";
  home.homeDirectory = "/home/pmpro";
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    bat
    feh
    git-filter-repo
    killall
    p7zip
    ripgrep
    scrot
    rxvt-unicode
    zathura
  ];

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.nix-mode
      epkgs.magit
    ];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
