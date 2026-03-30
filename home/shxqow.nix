{ config, pkgs, inputs, pkgsUnstable, pkgsCachyos, ... }:

{
  imports = [
    # DMS
    inputs.dms.homeModules.dank-material-shell
    inputs.dms-plugin-registry.modules.default

    # Home modules
    ./aesthetic.nix
    ./shell.nix
    ./programs.nix
    ./services.nix
    ./files.nix
  ];

  home.username    = "shxqow";
  home.homeDirectory = "/home/shxqow";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  programs.dank-material-shell = {
    enable = true;
    plugins = {
      dankKDEConnect.enable = true;
    };
  };
}
