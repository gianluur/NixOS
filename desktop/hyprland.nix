{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL     = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM    = "wayland;xcb";
    GDK_BACKEND        = "wayland,x11";
    SDL_VIDEODRIVER    = "wayland";
    CLUTTER_BACKEND    = "wayland";
  };

  programs.dconf.enable = true;
}
