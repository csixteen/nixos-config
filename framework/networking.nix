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
      userControlled = {
        enable = true;
      };

      networks = {
        YOUR_SSID = {
          psk = "CHANGE_ME";
        };
      };
    };
  };
}
