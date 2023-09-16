{ inputs, lib, config, pkgs, ... }: {
  programs.vscode = {
    enable  = true;
    package = pkgs.vscodium;

    mutableExtensionsDir = true;
  };

  xdg.desktopEntries = {
    vscodium = {
      name = "Visual Studio Code (OSS)";
      genericName = "custom desktop file for vscodium";
      exec = "sh -c \"codium --extensions-dir \"\\$XDG_DATA_HOME/vscode\" && sleep 1 && rm -r \\$HOME/.vscode-oss\"";
      terminal = false;
    };
  };
}
