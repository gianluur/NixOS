{ config, pkgs, pkgsUnstable, ... }:

{
  environment.systemPackages = with pkgs; [
    # === C / C++ ===
     gcc
     clang
     llvm
     lldb
     clang-tools    # clangd, clang-format, clang-tidy
     cmake
     gnumake
     ninja
     meson
     pkg-config
     gdb
     valgrind
     ccache

     # === Rust ===
     rustup

     # === Java / JVM ===
     jdk21
     gradle
     maven

     # === JavaScript / TypeScript ===
     nodejs_22
     nodePackages.npm
     nodePackages.pnpm
     bun

     # === Go ===
     go
     gopls

     # === Python ===
     python3
     uv              # fast Python package manager

     # === Build essentials ===
     openssl
     openssl.dev
     libiconv

     # === Database CLI ===
     sqlite
     pgcli           # postgres TUI client
     mycli           # mysql TUI client
     dbeaver-bin     # universal DB GUI
  ];
}
