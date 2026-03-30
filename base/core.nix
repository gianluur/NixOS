{ config, pkgs, pkgsCachyos, inputs, ... }:

{
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      allowed-users = [ "@wheel" ];
      require-sigs = true;
      max-jobs = "auto";
      cores = 0;
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://attic.xuyh0120.win/lantian"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCUSeBs="
        "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      min-free = ${toString (1024 * 1024 * 1024)}
    '';
    registry.nixpkgs.flake = inputs.nixpkgs;
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  };

  boot = {
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
      };
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
    kernelParams = [
      "quiet"
      "mitigations=auto"
      "nowatchdog"
      "nmi_watchdog=0"
    ];
    kernel.sysctl = {
      # Network performance
      "net.core.default_qdisc"          = "fq";
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.core.rmem_max"               = 2500000;

      # Network security
      "net.ipv4.conf.all.rp_filter"          = 1;
      "net.ipv4.conf.all.accept_source_route" = 0;

      # Memory
      "vm.swappiness"         = 10;
      "vm.vfs_cache_pressure" = 50;

      # Kernel hardening
      "kernel.kptr_restrict" = 1;

      # Dev tooling
      "fs.inotify.max_user_watches" = 524288;
    };
  };

  # Compressed RAM swap — effectively free extra memory
  zramSwap.enable = true;

  # Kills processes gracefully before the kernel OOM killer freezes the system
  services.earlyoom.enable = true;

  # Periodic SSD TRIM for longevity
  services.fstrim.enable = true;

  # Faster, more secure D-Bus implementation
  services.dbus.implementation = "broker";
}
