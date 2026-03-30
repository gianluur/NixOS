{ config, pkgs, ... }:

{
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true; # use GPG key for SSH authentication
    defaultCacheTtl  = 3600;
    maxCacheTtl      = 86400;
    pinentryPackage  = pkgs.pinentry-gnome3;
  };
}
