# My Nix MacOS configuration

![image](https://user-images.githubusercontent.com/24897042/98952066-4d777e00-24fb-11eb-8b82-49cef6bc12bc.png)

## Setup


```bash

# nix
sh <(curl -L https://nixos.org/nix/install)

# arm support
# rosetta 2
/usr/sbin/softwareupdate --install-rosetta --agree-to-license
#nix (https://github.com/NixOS/nix/issues/2925#issuecomment-539570232)
sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume

# bash
echo ". $HOME/.nix-profile/etc/profile.d/nix.sh" >> ~/.bashrc
source ~/.bashrc


# home manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --update
nix-shell '<home-manager>' -A install

# nix darwin
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
./result/bin/darwin-installer

mv /etc/bashrc /etc/bashrc.orig
echo 'if test -e /etc/static/bashrc; then . /etc/static/bashrc; fi' | sudo tee -a /etc/bashrc
echo 'if test -e /etc/static/bashrc; then . /etc/static/bashrc; fi' | tee -a ~/.bashrc

ssh-keygen  # then, add to Github

nix-shell -p git
...
git clone git@github.com:blaadje/Mac-dotfiles.git $HOME/.nixpkgs
cd $HOME/.nixpkgs
```
