{ ... }: {
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    historyLimit = 8192;

    extraConfig = ''
      set-option -g mouse on
    '';
  };
}

