{ pkgs, ... }: {
  home.sessionVariables = {
    EDITOR = "${pkgs.helix}/bin/hx";
  };

  programs.helix = {
    enable = true;

    settings = {
      theme = "catppuccin";

      editor = {
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
    };

    themes = {
      catppuccin = let
        transparent = "none";
        white       = "#cdd6f4";
        gray        = "#6c7086";
        dark-gray   = "#45475a";
        black       = "#181825";
        red         = "#f38ba8";
        green       = "#a6e3a1";
        yellow      = "#f9e2af";
        orange      = "#fab387";
        blue        = "#89b4fa";
        cyan        = "#89dceb";
        magenta     = "#cba6f7";
        lavender    = "#b4befe";
      in {
        "ui.menu" = transparent;
        "ui.menu.selected" = { modifiers = [ "reversed" ]; };
        "ui.linenr" = { fg = lavender; bg = transparent; };
        "ui.popup" = { modifiers = [ "reversed" ]; };
        "ui.linenr.selected" = { fg = lavender; bg = transparent; modifiers = [ "bold" ]; };
        "ui.selection" = { fg = black; bg = blue; };
        "ui.selection.primary" = { modifiers = [ "reversed" ]; };
        "ui.gutter" = { bg = transparent; };
        "ui.gutter.selected" = { bg = transparent; };
        "comment" = { fg = gray; };
        "ui.statusline" = { fg = white; bg = dark-gray; };
        "ui.statusline.inactive" = { fg = dark-gray; bg = white; };
        "ui.help" = { fg = dark-gray; bg = white; };
        "ui.cursor" = { modifiers = [ "reversed" ]; };
        "variable" = red;
        "variable.builtin" = orange;
        "constant.numeric" = orange;
        "constant" = orange;
        "attributes" = yellow;
        "type" = yellow;
        "ui.cursor.match" = { fg = yellow; modifiers = [ "underlined" ]; };
        "string" = green;
        "variable.other.member" = red;
        "constant.character.escape" = cyan;
        "function" = blue;
        "constructor" = blue;
        "special" = blue;
        "keyword" = magenta;
        "label" = magenta;
        "namespace" = blue;
        "diff.plus" = green;
        "diff.delta" = yellow;
        "diff.minus" = red;
        "diagnostic" = { modifiers = [ "underlined" ]; };
        "info" = blue;
        "hint" = dark-gray;
        "debug" = dark-gray;
        "warning" = yellow;
        "error" = red;
      };
    };
  };
}
