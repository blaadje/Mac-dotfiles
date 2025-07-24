{ pkgs,config, ... }:with pkgs;{
  profiles.default.extensions = with vscode-utils;
    (extensionsFromVscodeMarketplace (import ./extensions.nix));
  profiles.default.userSettings = import ./settings.nix { inherit config; };
}
