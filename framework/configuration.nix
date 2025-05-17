# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  lib = pkgs.lib;
in
{
  # Load other configuration files
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Add customized configuration for Framework 13 AMD
      <nixos-hardware/framework/13-inch/7040-amd>
      ./acpi.nix
      ./amdgpu.nix
      ./audio.nix
      #./bluetooth.nix
      ./networking.nix
      ./none_i3.nix
      ./power-management.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Install the latest kernel from the NixOS channel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Minimal kernel params, including the one that disables ASPM (which seems
  # to enable suspend to work when using a dock).
  boot.kernelParams = [
    "amdgpu.dcdebugmask=0x10"
    "pcie_aspm=off"
  ];

  hardware.enableRedistributableFirmware = true;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  console = {
    packages = with pkgs; [
      terminus_font
    ];

    font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    keyMap = "us";
  };

  fonts.packages = with pkgs; [
    fira-code
    hack-font
    iosevka
    roboto-mono
    (nerdfonts.override { fonts = [
      "FiraCode"
      "Hack"
      "Iosevka"
      "RobotoMono" 
    ]; })
  ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  environment.pathsToLink = ["/libexec"];

  # Enable the bolt protocol for thunderbolt docks
  services.hardware.bolt.enable = true;

  users.users.pmpro = {
    isNormalUser = true;
    description = "Pedro";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "input" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    acpid
    dig
    gcc
    gdb
    git
    htop
    iotop
    light
    linux-firmware
    lm_sensors
    netcat
    nix-search-cli
    nix-tree
    nixfmt-classic
    nvme-cli
    pamixer
    pstree
    sysstat
    tcpdump
    traceroute
    tree
    vim
    wget
    xorg.xhost
    zip
    zlib
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # BIOS updates are distributed through LVFS
  # To update, run:
  # 1. fwupdmgr refresh --force
  # 2. fwupdmgr get-updates
  # 3. fwupdmgr update
  services.fwupd.enable = true;

  # Configure the automatic mounting of external
  # USB drivers
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Configure automatic garbage collection for NixOS state;
  # this controls the number of generations that are kept
  # inside the Nix store, and thus the number of system
  # configurations that are available for selection during
  # boot.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d --keep-generations 5";
    randomizedDelaySec = "1 hour";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
