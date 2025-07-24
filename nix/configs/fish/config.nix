{ config, ... }: {
  interactiveShellInit = import ./settings.nix { inherit config; };
  functions = {
    vi.body =
      "alacritty --title vimwindow --working-directory (pwd) -e nvim $argv &";
  };
  shellAliases = {
    ls = "eza --icons --git --oneline";
    ll = "eza -l --icons --git";
    la = "eza -la --icons --git";
  };
}
