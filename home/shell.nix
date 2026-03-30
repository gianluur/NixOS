{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    eza
    zoxide
    bat
    fzf
    ripgrep
    fd
    tldr        # simplified man pages
    dust        # intuitive du replacement
    procs       # modern ps replacement
    fnm         # fast Node version manager
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls   = "eza --icons --group-directories-first";
      tree = "eza --tree --icons";
      cat  = "bat";
      cd   = "z";
      cdf  = ''cd "$(zoxide query -l | fzf)"'';

      # Git
      gs   = "git status";
      gp   = "git push";
      gl   = "git pull";
      glog = "git log --oneline --graph --decorate";

      # Docker
      dps = "docker ps";
      dcu = "docker compose up -d";
      dcd = "docker compose down";
    };

    initExtra = ''
      eval "$(zoxide init zsh)"

      # Rust
      export PATH="$HOME/.cargo/bin:$PATH"

      # Go
      export GOPATH="$HOME/go"
      export PATH="$GOPATH/bin:$PATH"

      # Java
      export JAVA_HOME="${pkgs.jdk21}"

      # Node version manager
      eval "$(fnm env --use-on-cd)"

      # Better history
      HISTSIZE=50000
      SAVEHIST=50000
      setopt HIST_IGNORE_DUPS
      setopt SHARE_HISTORY

      # Edit command in $EDITOR with Ctrl+E
      autoload edit-command-line
      zle -N edit-command-line
      bindkey '^e' edit-command-line
    '';
  };

  programs.eza    = { enable = true; icons = "auto"; git = true; };
  programs.bat    = { enable = true; config.theme = "base16"; };
  programs.fzf.enable    = true;
  programs.zoxide.enable = true;
}
