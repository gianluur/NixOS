{ config, pkgs, ... }:

{
  security = {
    rtkit.enable = true;
    sudo.wheelNeedsPassword = true;
    polkit.enable = true;
    protectKernelImage = true;

    apparmor = {
      enable = true;
      killUnconfinedConfinables = false;
      packages = [ pkgs.apparmor-profiles ];
    };
  };
}
