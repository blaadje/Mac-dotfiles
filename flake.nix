{
  description = "Nix Darwin System Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:lnl7/nix-darwin";
    nixvim.url = "github:nix-community/nixvim";
    nix-colors.url = "github:misterio77/nix-colors";
    home-manager.url = "github:nix-community/home-manager/master";
    nix-ai-tools.url = "github:numtide/nix-ai-tools";

    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, darwin, home-manager, nix-colors, nixvim, nix-ai-tools, ... }:
  let
    darwinSystem = "aarch64-darwin"; # ou "x86_64-darwin" selon ton architecture
    linuxSystem = "x86_64-linux"; # Pour WSL NixOS
  in {
    darwinConfigurations."JP4N99N4TV" = darwin.lib.darwinSystem {
      system = darwinSystem;
      specialArgs = {
        inherit nix-colors nixvim nix-ai-tools;
      };
      modules = [
        ./darwin-configuration.nix
        nix-colors.homeManagerModule
        home-manager.darwinModules.home-manager
        {
          nixpkgs.overlays = [ (final: prev: nix-ai-tools.packages.${darwinSystem}) ];
        }
      ];
    };

    # Configuration Debian avec Home Manager standalone
    homeConfigurations."aukx@debian" =
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${linuxSystem}.extend (final: prev: 
          nix-ai-tools.packages.${linuxSystem}
        );
        extraSpecialArgs = {
          inherit nix-colors nixvim;
        };
        modules = [ ./debian-home.nix ];
      };
  };
}
