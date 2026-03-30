{ config, pkgs, inputs, pkgsUnstable, pkgsCachyos, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../base/core.nix
    ../../base/security.nix
    ../../base/networking.nix
    ../../base/audio.nix
    ../../base/fonts.nix
    ../../base/apps.nix
    ../../hardware/nvidia.nix
    ../../desktop/hyprland.nix
    ../../functionalities/development.nix
    ../../functionalities/containers.nix
    ../../functionalities/compatibility.nix
    inputs.dms.nixosModules.dank-material-shell
  ];

  # nh (nix helper) needs to know where the flake is
  environment.variables.NH_FLAKE = "/etc/nixos";

  networking.hostName = "nixos";
  time.timeZone = "Europe/Rome";
  i18n.defaultLocale = "en_US.UTF-8";

  # Italian units/formats while keeping English UI
  i18n.extraLocaleSettings = {
    LC_ADDRESS        = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT    = "it_IT.UTF-8";
    LC_MONETARY       = "it_IT.UTF-8";
    LC_NAME           = "it_IT.UTF-8";
    LC_NUMERIC        = "it_IT.UTF-8";
    LC_PAPER          = "it_IT.UTF-8";
    LC_TELEPHONE      = "it_IT.UTF-8";
    LC_TIME           = "it_IT.UTF-8";
  };

  # Firmware blobs for WiFi cards, BT, etc.
  hardware.enableRedistributableFirmware = true;

  # Power info used by DMS bar widgets
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  users.users.shxqow = {
    isNormalUser = true;
    description = "shxqow";
    extraGroups = [ "wheel" "networkmanager" "docker" "video" "audio" ];
    shell = pkgs.zsh;
  };

  programs.dank-material-shell = {
    enable = true;
    enableSystemMonitoring = true;
    systemd.enable = true;
    dgop.package = inputs.dgop.packages.${pkgs.system}.default;
  };

  system.stateVersion = "25.11";
}
