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
    ".local/share/applications/discord.desktop".text = ''
      [Desktop Entry]

      Type=Application

      Name=Discord

      Comment=Voice and text chat, wrapped for Wayland

      Exec=discord --enable-features=UseOzonePlatform --ozone-platform-hint=auto

      Terminal=false
    '';
  };
}

