{ pkgs,config, ... }:with pkgs;{
  extensions = with vscode-utils;
    (extensionsFromVscodeMarketplace (import ./extensions.nix));
  userSettings = import ./settings.nix { inherit config; };
}
