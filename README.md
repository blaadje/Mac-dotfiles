# My Nix MacOS configuration

## Setup

```bash
# nix
curl -L https://nixos.org/nix/install | sh

# home manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --update
nix-shell '<home-manager>' -A install

# nix darwin
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
./result/bin/darwin-installer

ssh-keygen  # then, add to Github

nix-shell -p git
...
git clone git@github.com:blaadje/Mac-dotfiles.git $HOME/.nixpkgs
cd $HOME/.nixpkgs
```
