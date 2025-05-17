{ lib, ... }:

{
  boot.initrd = lib.mkMerge [{
    kernelModules = [ "amdgpu" ];
  }];

  hardware.graphics = {
    enable = lib.mkDefault true;
    enable32Bit = lib.mkDefault true;
  };

  hardware.amdgpu.initrd.enable = lib.mkDefault true;
}

