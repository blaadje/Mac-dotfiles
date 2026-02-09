{ lib, pkgs, ... }:

let
  skhdModule = import ./skhd-module.nix { inherit lib pkgs; };
  skhdConfigFile = "${skhdModule.skhdConfig}/skhd-configuration";
in {
  home.file.".skhdrc" = {
    text = builtins.readFile skhdConfigFile;
  };
}
