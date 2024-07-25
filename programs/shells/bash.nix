{ ... }: {
  programs.bash = {
    enable = true;

    enableCompletion = true;

    historyFile = "$XDG_STATE_HOME/bash/history";
    historySize = 10000;
  };
}

