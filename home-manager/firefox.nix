{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    package = pkgs.firefox;
    configPath = "${config.xdg.configHome}/mozilla/firefox";

    policies = {
      Preferences = {
       "media.ffmpeg.vaapi.enabled" = {
         Value = true;
         Status = "default";
       };

       "media.hardware-video-decoding.force-enabled" = {
         Value = true;
         Status = "default";
       };

       "gfx.webrender.all" = {
         Value = true;
         Status = "default";
       };
      };
    };
  };
}
