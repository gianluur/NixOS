{ config, pkgs, ... }:

{
  # Allows running unpatched binaries (pre-built tools, npm scripts, installers)
  # Without this, they fail with cryptic "no such file" errors on NixOS
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
      zlib
      fuse3
      icu
      nss
      openssl
      expat
      libgcc
      glib
      gtk3
      xorg.libX11
      xorg.libXcursor
      xorg.libXrandr
      xorg.libXi
      vulkan-loader
      libGL
      alsa-lib
      libpulseaudio
      freetype
      fontconfig
    ];
  };
}
