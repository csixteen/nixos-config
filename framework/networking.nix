{ config, pkgs, ... }:

{
  networking = {
    firewall = {
      enable = true;

      allowedTCPPorts = [ 22 ];
    };

    hostName = "nixos";

    nftables.enable = true;

    wireless = {
      enable = true;
      userControlled = true;
      extraConfig = ''
        country=NL
        bgscan="simple:30:-75:300"
        autoscan="exponential:3:30"
      '';

      extraConfigFiles = [
        "/etc/wpa_supplicant/private-networks.conf"
      ];
    };
  };
}
