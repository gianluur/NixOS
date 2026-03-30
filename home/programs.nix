{ config, pkgs, pkgsUnstable, ... }:

{
  home.packages = with pkgs; [
    libsecret    # for git credential.helper = libsecret
    lazydocker   # docker TUI
    gh           # GitHub CLI
    just         # command runner
    hyperfine    # benchmarking
    tokei        # count lines of code
    ffmpeg_7-full
    exiftool
  ];

  programs.git = {
    enable = true;
    userName  = "gianluur";
    userEmail = "gianluca.rssu@protonmail.com";
    extraConfig = {
      credential.helper  = "libsecret"; # stores in GNOME keyring, not plaintext
      push.autoSetupRemote = true;
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias  = true;
    vimAlias = true;
  };

  programs.lazygit.enable   = true;
  programs.fastfetch.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true; # fast nix shell environments
  };

  programs.gpg.enable = true;
}
