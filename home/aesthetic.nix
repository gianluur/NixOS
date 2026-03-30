{ config, pkgs, ... }:

let
  macos-tahoe-cursors = pkgs.stdenv.mkDerivation {
    pname   = "macos-tahoe-cursors";
    version = "1.2";
    src = pkgs.fetchurl {
      url    = "https://github.com/witt-bit/MacOS-Tahoe-Cursor/releases/download/1.2/MacOS-Tahoe-Cursor.zip";
      sha256 = "sha256-aEuAKWoEGVl/fv61yA09lSf4pmOdDZikmOYu2PqNjhI=";
    };
    nativeBuildInputs = [ pkgs.unzip ];
    unpackPhase = "unzip $src";
    installPhase = ''
      mkdir -p $out/share/icons/MacOS-Tahoe
      cp -r MacOS-Tahoe-Cursor/MacOS-Tahoe-Cursor/* $out/share/icons/MacOS-Tahoe/
    '';
  };
in
{
  home.packages = with pkgs; [
    macos-tahoe-cursors
    adwaita-icon-theme
    adwaita-fonts
    qt6Packages.qt6ct
    libsForQt5.qt5ct
  ];

  # GTK theme, icons, cursor, font
  gtk = {
    enable = true;
    theme = {
      name    = "Tokyonight-Purple-Dark";
      package = pkgs.tokyonight-gtk-theme.override {
        colorVariants = [ "dark" ];
        tweakVariants  = [ "macos" ];
        themeVariants  = [ "purple" ];
      };
    };
    iconTheme = {
      name    = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    cursorTheme = {
      name    = "MacOS-Tahoe";
      package = macos-tahoe-cursors;
      size    = 24;
    };
    font = {
      name = "Adwaita Sans";
      size = 11;
    };
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  # GTK4 requires manual CSS symlinking to actually apply the theme
  xdg.configFile."gtk-4.0/gtk.css".source      = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
  xdg.configFile."gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  xdg.configFile."gtk-4.0/assets".source       = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";

  # Qt follows GTK theme
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name         = "gtk2";
  };

  # Dark mode + macOS-style window buttons system-wide
  dconf.settings = {
    "org/gnome/desktop/interface".color-scheme       = "prefer-dark";
    "org/gnome/desktop/wm/preferences".button-layout = ":minimize,maximize,close";
  };

  # Cursor env vars for Hyprland (native) and XWayland
  home.sessionVariables = {
    XCURSOR_THEME    = "MacOS-Tahoe";
    XCURSOR_SIZE     = "24";
    HYPRCURSOR_THEME = "MacOS-Tahoe";
    HYPRCURSOR_SIZE  = "24";
  };
}
