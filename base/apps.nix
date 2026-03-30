{ config, pkgs, pkgsUnstable, inputs, ... }:

{
  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    # === Shell ===
     zsh
     kitty
     zed-editor

     # === Nix Helpers ===
     nh                   # better nixos-rebuild wrapper
     nix-output-monitor   # pretty build output
     nvd                  # diff between system generations

     # === Apps ===
     brave
     btop
     gnome-disk-utility
     gnome-logs
     evince
     nautilus
     gnome-photos
     flatseal
     onlyoffice-bin
     vlc
     distroshelf

     # === Base Utilities ===
     wget
     curl
     git
     jq
     yq
     wl-clipboard         # wl-copy / wl-paste for Wayland clipboard
     cliphist             # clipboard history manager
     libnotify            # notify-send

     # === Hyprland Ecosystem ===
     hyprshot             # screenshots
     hyprpicker           # color picker
     hypridle             # idle daemon
     hyprlock             # lock screen
     brightnessctl        # brightness control (used by DMS IPC)
     playerctl            # media key control

     # === Archives ===
     p7zip
     unrar
     unzip
     atool

     inputs.snappy-switcher.packages.${pkgs.system}.default
  ];

  programs.zsh.enable = true;
  programs.kdeconnect.enable = true;
}
