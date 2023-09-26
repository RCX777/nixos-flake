{ inputs, lib, config, pkgs, ... }: {
  programs.zsh = {
    enable = true;

    enableCompletion         = true;
    enableAutosuggestions    = true;
    enableSyntaxHighlighting = true;
    enableVteIntegration     = true;

    dotDir = ".config/zsh"; # Assumes that $HOME is the parent dir of `.config`

    history = {
      path = "${config.xdg.stateHome}/zsh/history";
      save = 1000;
    };

    shellAliases = {
      ls    = "exa --icons --color=always";
      grep  = "rg";
      ps    = "procs";
      find  = "fd";
      cat   = "bat";
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
