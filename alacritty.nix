{
  env = {
    "TERM" = "xterm-256color";
  };

  window = {
    padding.x = 15;
    padding.y = 15;
    decorations = "buttonless";
  };

  font = {
    size = 18.0;
    use_thin_strokes = true;

    normal.family = "FuraCode Nerd Font";
    bold.family = "FuraCode Nerd Font";
    italic.family = "FuraCode Nerd Font";
  };

  shell = {
    program = "/etc/profiles/per-user/alex/bin/fish";
  };

  colors = {
    # Default colors
    primary = {
      background = "0x1b182c";
      foreground = "0xcbe3e7";
    };

    # Normal colors
    normal = {
      black=   "0x3B4252";
      red=     "0xBF616A";
      green=   "0xA3BE8C";
      yellow=  "0xEBCB8B";
      blue=    "0x81A1C1";
      magenta= "0xB48EAD";
      cyan=    "0x88C0D0";
      white=   "0xE5E9F0";
    };

    # Bright colors
    bright = {
      black=   "0x4C566A";
      red=     "0xBF616A";
      green=   "0xA3BE8C";
      yellow=  "0xEBCB8B";
      blue=    "0x81A1C1";
      magenta= "0xB48EAD";
      cyan=    "0x8FBCBB";
      white=   "0xECEFF4";
    };
  };
}