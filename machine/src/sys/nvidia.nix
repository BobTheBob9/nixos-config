{ config, ... }:
{
  services.xserver.videoDrivers = [ "nvidia" ];

  # Optionally, you may need to select the appropriate driver version for your specific GPU.
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest; 
  hardware.nvidia.modesetting.enable = true; # nvidia-drm.modeset=1 is required for some wayland compositors, e.g. sway 
  hardware.nvidia.powerManagement.enable = true; # fixes suspend issues
  hardware.nvidia.open = false; # proprietary driver until open source one is good enough 
  hardware.nvidia.nvidiaSettings = false;

  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;

  #environment.variables.WLR_NO_HARDWARE_CURSORS = "1";
}

