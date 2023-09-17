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
      code  = "codium --extensions-dir \"$XDG_DATA_HOME/vscode\" && sleep 1 && rm -r $HOME/.vscode-oss";
      flake = "sudo nixos-rebuild switch --upgrade --flake";
    };

    initExtra = ''
      # Sets up the prompt
      PROMPT="%F{121}%n%f@%F{121}%m%f:%F{147}%~/ %(?.%F{121}.%F{red})%#%f "

      # Binds Ctrl-Arrow(right/left)
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
    '';
  };
}
