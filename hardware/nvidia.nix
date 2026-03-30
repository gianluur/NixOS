{ config, pkgs, ... }:

{
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    powerManagement = {
      enable = true;
    };
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  boot = {
    kernelParams = [ "nvidia-drm.modeset=1" "nvidia-drm.fbdev=1" ];
    initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_drm" ];
    blacklistedKernelModules = [ "nouveau" ];
  };

  environment.sessionVariables = {
    GBM_BACKEND               = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME         = "nvidia"; # hardware video acceleration
  };
}
