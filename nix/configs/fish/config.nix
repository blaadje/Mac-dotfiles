{ config, ... }: {
  interactiveShellInit = import ./settings.nix { inherit config; };
  functions = {
    vi.body =
      "alacritty --title vimwindow --working-directory (pwd) -e nvim $argv &";
  };
}
