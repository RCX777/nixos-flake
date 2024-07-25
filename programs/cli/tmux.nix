{ pkgs, ... }: {
  programs.tmux = {
    enable = true;

    terminal = "screen-256color";
    mouse = true;

    shortcut = "a";

    extraConfig = ''
      set-option -a terminal-features "alacritty:RGB"

      unbind '"'
      unbind %
      bind | split-window -h -c '#{pane_current_path}'
      bind - split-window -v -c '#{pane_current_path}'

      unbind &
      unbind x
      bind-key & kill-window
      bind-key x kill-pane

      bind -n M-H previous-window
      bind -n M-L next-window

      set -g @plugin 'tmux-plugins/tpm'
      set -g @plugin 'tmux-plugins/tmux-sensible'
      set -g @plugin 'dreamsofcode-io/catppuccin-tmux'

      run '~/.local/share/tmux/plugins/tpm/tpm'
    '';

    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
    ];
  };

  # home = {
  #   file."${config.xdg.configHome}/tmux/tmux.conf" = {
  #     recursive = true;
  #     source    = ./tmux.conf;
  #   };
  # };
}

