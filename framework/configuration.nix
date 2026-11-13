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
      ./virtualisation.nix
    ];

  # Bootloader.
  boot.extraModprobeConfig = ''
    options cfg80211 ieee80211_regdom="NL"
  '';
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Install the latest kernel from the NixOS channel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Minimal kernel params, including the one that disables ASPM (which seems
  # to enable suspend to work when using a dock).
  boot.kernelParams = [
    # The following should be set only when experiencing white-screen flickering,
    # which should actually have been fixed in newer AMD firmware and kernels.
    # The setting may drain battery because it disables Panel Self-Refresh (PSR)
    # on the AMD display controller. The PSR allows the display panel to refresh
    # static images from its own internal memory while the GPU shuts down between
    # frames. That means that disabling PSR forces the Radeon 760M to stay awake
    # continuously whenever the screen is on.
    # "amdgpu.dcdebugmask=0x10"

    # The following is disabled because it "may" drain battery. ASPM (Active
    # State Power Management) allows PCIe devices - most notably NVMe SSD, Wi-Fi
    # card, and Thunderbolt/USB4 controllers - to power down when idle. By
    # disabling ASPM, we're keeping these links running at full power 100% of the
    # time, which may add 2W to 4W continuous drain, even if the laptop is doing
    # nothing, or suspended.
    # "pcie_aspm=off"
  ];

  hardware.enableRedistributableFirmware = true;

  # Enable flakes
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" ];
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  console = {
    packages = with pkgs; [
      terminus_font
    ];

    font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    keyMap = "us";
  };

  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;

    fontconfig = {
      defaultFonts.emoji = ["Noto Color Emoji"];
    };

    packages = with pkgs; [
      fira-code
      hack-font
      iosevka
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      roboto-mono
      nerd-fonts.fira-code
      nerd-fonts.iosevka
      nerd-fonts.hack
      nerd-fonts.roboto-mono
    ];
  };

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
    extraGroups = [ "networkmanager" "wheel" "audio" "video" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    acpid
    acpilight
    atop
    brightnessctl
    dig
    gcc
    gdb
    git
    gnumake
    htop
    iotop
    iw
    linux-firmware
    perf
    lm_sensors
    lsof
    netcat
    nh
    nix-search-cli
    nix-tree
    nixfmt
    nvme-cli
    pamixer
    pciutils
    powerstat
    powertop
    pstree
    sysstat
    tcpdump
    traceroute
    tree
    usbutils
    unzip
    vim
    wget
    xcompmgr
    xhost
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
  services.openssh = {
    enable = true;

    settings = {
      AllowUsers = [ "pmpro" ];
      PermitRootLogin = "no";

      PasswordAuthentication = true;  # disable this later
      KbdInteractiveAuthentication = false;
      PubkeyAuthentication = true;
    };
  };

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
    options = "--delete-older-than 20d";
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
