{ inputs, lib, config, pkgs, ... }: {
  programs.bash = {
    enable = true;

    enableCompletion = true;

    historyFile = "$XDG_STATE_HOME/bash/history";
    historySize = 10000;

    shellAliases = {
      code = "codium --extensions-dir \"$XDG_DATA_HOME/vscode\" && sleep 1 && rm -r $HOME/.vscode-oss";
    };
  };
}