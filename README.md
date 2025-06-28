# My Nix MacOS configuration

<img width="1512" alt="image" src="https://github.com/user-attachments/assets/6229f9b1-c79a-4df0-9e66-9a58c2dd3811" />

## Setup

```bash

# rosetta 2
/usr/sbin/softwareupdate --install-rosetta --agree-to-license

#nix (https://github.com/NixOS/nix/issues/2925#issuecomment-539570232)
sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume --daemon

# bash
echo ". $HOME/.nix-profile/etc/profile.d/nix.sh" >> ~/.bashrc
source ~/.bashrc

# home manager
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

NIX_PATH=~/.nix-defexpr/channels:nixpkgs=~/.nix-defexpr/channels/nixpkgs nix-shell '<home-manager>' -A install

# config
nix-shell -p git
...
git clone https://github.com/blaadje/Mac-dotfiles.git $HOME/.nixpkgs
cd $HOME/.nixpkgs

# nix darwin
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
./result/bin/darwin-installer

# git
ssh-keygen  # then, add to Github

# case of failing diskutils
export PATH=$PATH:/usr/sbin

#case of certificate issue
https://github.com/NixOS/nix/issues/2899#issuecomment-699299567

# case of permission issue
sudo rm /etc/ssl/certs/ca-certificates.crt && sudo ln -s /nix/var/nix/profiles/default/etc/ssl/certs/ca-bundle.crt /etc/ssl/certs/ca-certificates.crt
```
