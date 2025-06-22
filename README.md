# My Nix MacOS configuration

<img width="1512" alt="image" src="https://github.com/user-attachments/assets/6229f9b1-c79a-4df0-9e66-9a58c2dd3811" />


## Setup


```bash
# 1. Installer Rosetta 2 (si tu es sur Apple Silicon)
sudo softwareupdate --install-rosetta --agree-to-license

# 2. Installer Nix (multi-user / daemon mode + volume non chiffré)
sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume --daemon

# 3. Activer l'environnement Nix (bash)
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

# 4. Activer les flakes (optionnel selon la version de Nix)
mkdir -p ~/.config/nix
echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf

# 5. Cloner ta configuration flake
git clone https://github.com/blaadje/Mac-dotfiles.git ~/.nixpkgs
cd ~/.nixpkgs

# 6. Installer nix-darwin via flake
nix run github:lnl7/nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/.nixpkgs#<hostname>

# Remplace <hostname> par celui défini dans ton darwin-configuration.nix (par ex. : "macbook-air-pete")

# 7. Ajouter ta clé SSH (si nécessaire)
ssh-keygen -t ed25519 -C "your@email.com"
cat ~/.ssh/id_ed25519.pub  # ajouter à GitHub

# (Optionnel) Cas particuliers
export PATH=$PATH:/usr/sbin  # pour diskutil si nécessaire

```
