{ ... }: {
  programs.git = {
    enable = true;

    # Pretty syntax highlighter for git diff & others
    delta = {
      enable = true;
    };

    signing = {
      signByDefault = true;
      key           = "D99664161A06F749";
    };

    userName  = "RCX777";
    userEmail = "robertcnst02@gmail.com";
  };
}
