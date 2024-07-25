{ config, ... }: {
  programs.zsh = {
    enable = true;

    enableCompletion     = true;
    enableVteIntegration = true;

    syntaxHighlighting = {
        enable = true;
    };

    autosuggestion = {
      enable = true;
    };

    dotDir = ".config/zsh"; # Assumes that $HOME is the parent dir of `.config`

    history = {
      path = "${config.xdg.stateHome}/zsh/history";
      save = 16384;
    };

    shellAliases = {
      # Alternatives to standard utilities
      ls    = "lsd";
      grep  = "rg";
      ps    = "procs";
      find  = "fd";
      cat   = "bat";
      cd    = "z";

      # Convenience aliases
      cl    = "clear";
      flake = "sudo nixos-rebuild switch --upgrade --flake";
    };

    initExtra = ''
      # Sets up the prompt
      PROMPT="%F{121}%n%f@%F{121}%m%f:%F{147}%~/ %(?.%F{121}.%F{red})%#%f "

      # Disables annoying x11-ssh-askpass (login is now done in the terminal)
      SSH_ASKPASS=""

      # Binds Ctrl-Arrow(right/left)
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
    '';
  };
}
