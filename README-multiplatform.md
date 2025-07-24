# Multi-Platform Nix Configuration

Cette configuration supporte à la fois **macOS** (avec nix-darwin) et **Ubuntu/Linux** (avec Home Manager).

## Structure

```
.nixpkgs/
├── flake.nix                    # Point d'entrée avec support multi-OS
├── darwin-configuration.nix     # Configuration système macOS
├── home-configuration.nix       # Configuration Home Manager (macOS + Linux)
├── nix/
│   ├── common/
│   │   └── packages.nix         # Packages partagés entre OS
│   ├── darwin/                  # Spécifique macOS (vide pour l'instant)
│   ├── linux/
│   │   └── services.nix         # Services Linux (i3, sway, etc.)
│   ├── configs/                 # Configurations d'applications
│   │   ├── vim/                 # Config Neovim
│   │   ├── sketchybar/          # SketchyBar (macOS only)
│   │   └── karabiner/           # Karabiner (macOS only)
│   └── ...
```

## Installation et Usage

### macOS (nix-darwin + Home Manager)

1. **Installation initiale :**
   ```bash
   # Installer Nix avec flakes
   curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
   
   # Installer nix-darwin
   nix run nix-darwin -- switch --flake .
   ```

2. **Rebuild :**
   ```bash
   darwin-rebuild switch --flake .
   ```

### Ubuntu/Linux (Home Manager seulement)

1. **Installation initiale :**
   ```bash
   # Installer Nix avec flakes
   curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
   
   # Installer Home Manager
   nix run home-manager/master -- switch --flake .#alexandre
   ```

2. **Rebuild :**
   ```bash
   home-manager switch --flake .#alexandre
   ```

## Fonctionnalités par OS

### Partagées (macOS + Linux)
- ✅ Neovim avec configuration complète
- ✅ Fish shell
- ✅ Git configuration
- ✅ Packages de développement (Node.js, LSP servers, etc.)
- ✅ Direnv
- ✅ Fonts (Nerd Fonts)

### macOS uniquement
- ✅ SketchyBar (barre de statut)
- ✅ Karabiner (remapping clavier)
- ✅ skhd (shortcuts clavier)
- ✅ AutoRaise
- ✅ Janky Borders

### Linux uniquement
- ✅ i3-wm ou Sway (gestionnaires de fenêtres)
- ✅ Picom (compositeur)  
- ✅ Dunst (notifications)
- ✅ xclip/wl-clipboard (clipboard)

## Personnalisation

### Changer de gestionnaire de fenêtres Linux

Dans `nix/linux/services.nix`, vous pouvez basculer entre i3 et Sway :

```nix
# Pour i3 (X11)
xsession.windowManager.i3.enable = true;
wayland.windowManager.sway.enable = false;

# Pour Sway (Wayland)  
xsession.windowManager.i3.enable = false;
wayland.windowManager.sway.enable = true;
```

### Ajouter des packages

Modifiez `nix/common/packages.nix` pour les packages partagés, ou ajoutez des packages spécifiques dans les sections `darwinSpecific` ou `linuxSpecific`.

## Dépannage

### Erreur "module not found"
Après avoir ajouté de nouveaux fichiers, rebuild la configuration.

### Problème de permissions Linux
```bash
sudo chown -R $USER:$USER ~/.config/home-manager
```

### Nettoyer le cache
```bash
nix-collect-garbage -d
```