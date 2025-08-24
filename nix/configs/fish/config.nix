{ config, ... }: {
  interactiveShellInit = ''
    ${import ./settings.nix { inherit config; }}
    # Add Homebrew to PATH for Fish (macOS only)
    if test -f /opt/homebrew/bin/brew
      eval "$(/opt/homebrew/bin/brew shellenv)"
    end
    # Load Qonto environment variables (converted from .zshrc format)
    if test -f ~/.zshrc
      # Extract and convert export statements to Fish syntax
      grep -E "^export [A-Z_]+=.*" ~/.zshrc | sed 's/export /set -gx /' | sed 's/=/ /' | source
    end

    # Auto-start nvim in terminal mode if not already in nvim
    if command -v nvim >/dev/null 2>&1; and test -z "$NVIM"
      nvim -c ':term' -c ':startinsert'
    end

  '';
  functions = {
    vi.body =
      "alacritty --title vimwindow --working-directory (pwd) -e nvim $argv &";
    nvopen.body = ''
      if test (count $argv) -gt 0
        set target_dir (realpath $argv[1])
      else
        set target_dir (pwd)
      end

      if test -n "$NVIM_SERVER"; and test -S "$NVIM_SERVER"
        nvim --server "$NVIM_SERVER" --remote-send "<C-\\><C-n>:cd $target_dir<CR>:e .<CR>"
        echo "Directory changed to $target_dir in nvim"
      else
        echo "No nvim server found (NVIM_SERVER=$NVIM_SERVER)"
      end
    '';
  };
  shellAliases = {
    ls = "eza --icons --git --oneline";
    ll = "eza -l --icons --git";
    la = "eza -la --icons --git";
    openhands = "uvx --python 3.12 --from openhands-ai openhands";
  };
}
