{ config, pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      userns-remap = "default"; # isolates container UIDs from host UIDs
    };
  };
  environment.systemPackages = with pkgs; [ distrobox ];
}
