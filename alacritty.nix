{
  # imports = [ ./colors/theme.nix ];

  env = {
    "TERM" = "xterm-256color";
  };

  window = {
    padding.x = 15;
    padding.y = 15;
    decorations = "buttonless";
  };

  font = {
    size = 16.0;
    use_thin_strokes = true;
    normal = {
      family = "DroidSansMono Nerd Font";
    };
  };

  # colors = with options.colors; {
  #   primary = { background = background; foreground = foreground; };
  #   cursor = { text = foreground; cursor = background; };
  #   normal = { inherit black red green yellow blue magenta cyan white; };
  # };

  shell = {
    program = "/etc/profiles/per-user/${builtins.getEnv("USER")}/bin/fish";
  };
}