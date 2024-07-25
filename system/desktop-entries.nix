{ config, ... }: {
  home.file = {
    ".local/share/applications/nvidia-settings.desktop".text = ''
      [Desktop Entry]

      Type=Application

      Name=Nvidia Settings

      Comment=XDG compliant wrapper over the Nvidia Settings app

      Exec=nvidia-settings --config=${config.xdg.configHome}/nvidia/settings

      Terminal=false
    '';
  };
}

