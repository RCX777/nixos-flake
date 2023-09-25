{ inputs, lib, config, pkgs, ... }: {
  services.xserver.displayManager.lightdm = {
      greeters.mini = {
        enable = true;
        user   = "rcx";
        extraConfig = ''
          [greeter]
          # The user to login as.
          user = rcx

          # Whether to show the password input's label.
          show-password-label = true

          # The text of the password input's label.
          password-label-text = Password:

          # The text shown when an invalid password is entered. May be blank.
          invalid-password-text = Invalid Password

          # Show a blinking cursor in the password input.
          show-input-cursor = false
  
          # The text alignment for the password input. Possible values are:
          # "left" or "right"
          password-alignment = right


          [greeter-theme]
          # A color from X11's `rgb.txt` file, a quoted hex string(`"#rrggbb"`) or a
          # RGB color(`rgb(r,g,b)`) are all acceptable formats.

          # The font to use for all text
          font = "HelveticaNeueLTStd-BdEx"

          # The font size to use for all text
          font-size = 12px

          # The default text color
          text-color = "#cdd6f4"

          # The color of the error text
          error-color = "#f38ba8"

          # An absolute path to an optional background image.
          # The image will be displayed centered & unscaled.
          background-image = "/home/rcx/Media/Images/Wallpapers/forest.png"

          # The screen's background color.
          background-color = "#11111b"

          # The password window's background color
          window-color = "#1e1e2e"

          # The color of the password window's border
          border-color = "#1e1e2e"

          # The width of the password window's border.
          # A trailing `px` is required.
          border-width = 2px

          # The pixels of empty space around the password input.
          # Do not include a trailing `px`.
          layout-space = 15

          # The color of the text in the password input.
          password-color = "#cdd6f4"

          # The background color of the password input.
          password-background-color = "#313244"

          # The color of the password input's border.
          password-border-color = "#000000"

          # The width of the password input's border.
          password-border-width = 0
        '';
      };
      # Currently commented out, as it breaks lutris
      # See https://github.com/NixOS/nixpkgs/issues/239054
      # extraConfig = ''
      #   user-authority-in-system-dir = true
      # '';
    };
}