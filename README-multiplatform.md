# Multi-Platform Nix Configuration

This Nix configuration supports both **macOS** (via nix-darwin) and **Debian/Ubuntu** (via standalone Home Manager).

## Structure

```
.
├── flake.nix                 # Main configuration
├── darwin-configuration.nix  # macOS configuration
├── debian-home.nix          # Debian/Ubuntu Home Manager configuration
└── nix/
    ├── common/
    │   └── packages.nix      # Common packages and programs
    ├── darwin/
    │   ├── packages.nix      # macOS-specific packages and programs
    │   └── services.nix      # macOS system services
    ├── linux/
    │   ├── packages.nix      # Linux-specific packages
    │   └── services.nix      # Linux services (minimal)
    └── configs/             # Detailed configurations
        ├── fish/
        ├── vim/
        ├── vscode/
        ├── aerospace.nix
        ├── sketchybar/
        └── ...
```

## Installation

### macOS (nix-darwin)

1. Install Nix with flakes:
```bash
sh <(curl -L https://nixos.org/nix/install)
```

2. Install nix-darwin:
```bash
nix run nix-darwin -- switch --flake .
```

3. Subsequent rebuilds:
```bash
darwin-rebuild switch --flake .
```

### Debian/Ubuntu (standalone Home Manager)

1. Install Nix:
```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```

2. Restart shell:
```bash
source ~/.bashrc
```

3. Copy configuration to `~/.config/home-manager/`

4. Install Home Manager and apply config:
```bash
cd ~/.config/home-manager
nix run home-manager/master -- switch --flake .#alexandre@debian
```

5. Subsequent rebuilds:
```bash
home-manager switch --flake .#alexandre@debian
```

## Packages and Programs

### Common (nix/common/packages.nix)
- **Development**: deno, docker, watchman, claude-code, ember-cli, etc.
- **LSP**: lua-language-server, pyright, typescript-language-server, nil, etc.
- **CLI**: autojump, btop, eza, gtop, neofetch, fzf, ripgrep, bat, tree, etc.
- **Web**: heroku, netlify-cli, nodejs, yarn
- **Programs**: 
  - Fish shell with autojump
  - Complete Neovim (nixvim)
  - Git with custom configuration
  - VSCode with extensions
  - Starship prompt
  - Kitty terminal

### macOS-specific (nix/darwin/packages.nix)
- **Packages**: aerospace, autoraise, karabiner-elements, xcbuild, etc.
- **Programs**:
  - Aerospace (window manager)
  - Sketchybar (status bar)

### Linux-specific (nix/linux/packages.nix)
- xclip, wl-clipboard (clipboard management)

## System Services

### macOS (nix/darwin/services.nix)
- **skhd**: Global keyboard shortcuts
- **JankyBorders**: Custom window borders
- **AutoRaise**: Automatic window focus

### Linux (nix/linux/services.nix)
- Minimal configuration (no window manager for WSL)

## Features

### Automatic configurations
- **Nix flakes** enabled on both platforms
- **Unfree packages** allowed
- **Home Manager** for user management
- **Nix-colors** for theming (Catppuccin Frappe)

### Integrated development tools
- **Direnv** with nix-direnv
- **Formatters**: nixfmt, prettier, lua-formatter
- **Linters**: eslint_d
- **Git** with delta for diffs

## Usage

### Update flakes
```bash
nix flake update
```

### Rebuild after modifications
```bash
# macOS
darwin-rebuild switch --flake .

# Debian/Ubuntu
home-manager switch --flake .#alexandre@debian
```

### Debug and maintenance
```bash
# View installed packages
nix profile list

# Clean store
nix-collect-garbage -d

# Check configuration
nix flake check
```

## Migration from NixOS

This configuration has been simplified to use standalone Home Manager instead of full NixOS, avoiding the complexities of system configuration on WSL/Ubuntu while maintaining the same user experience.