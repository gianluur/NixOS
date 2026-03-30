{ config, pkgs, ... }:

{
  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
    wifi.scanRandMacAddress = true; # randomize MAC on WiFi scans for privacy
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [];
    allowedUDPPorts = [];
  };

  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = [ "~." ]; # handle all DNS queries through resolved
    fallbackDns = [ "9.9.9.9" "149.112.112.112" ];
    extraConfig = "DNSOverTLS=opportunistic";
  };
}
