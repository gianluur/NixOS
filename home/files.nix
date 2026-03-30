{ config, pkgs, ... }:

{
  home.file = {
    ".config/nvim".source = ./config/nvim;
  };

  xdg.configFile = {
    # Hyprland
    "hypr/hyprland.conf".source = ./config/hypr/hyprland.conf;

    # Kitty
    "kitty/kitty.conf".source         = ./config/kitty/kitty.conf;
    "kitty/current-theme.conf".source = ./config/kitty/current-theme.conf;
    "kitty/dank-tabs.conf".source     = ./config/kitty/dank-tabs.conf;
    "kitty/dank-theme.conf".source    = ./config/kitty/dank-theme.conf;
  };
}
