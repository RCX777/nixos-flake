{ inputs, lib, config, pkgs, ... }: {
  programs.zsh = {
    enable = true;

    enableCompletion      = true;
    enableAutosuggestions = true;

    syntaxHighlighting = {
      enable = true;
    };

    history = {
      path = "${config.xdg.cacheHome}/zsh/history";
      save = 1000;

      SubstringSearch = {
        enable = true;
        caseSensitive = false;
      }
    };

    shellAliases = {
      code = "codium --extensions-dir \"$XDG_DATA_HOME/vscode\" && sleep 1 && rm -r $HOME/.vscode-oss";
    };
  };
}