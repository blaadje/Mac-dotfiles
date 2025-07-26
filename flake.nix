{
  description = "Nix Darwin System Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:lnl7/nix-darwin";
    nixvim.url = "github:nix-community/nixvim";
    nix-colors.url = "github:misterio77/nix-colors";
    home-manager.url = "github:nix-community/home-manager/master";

    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, darwin, home-manager, nix-colors, nixvim, ... }:
    let 
      darwinSystem = "aarch64-darwin"; # ou "x86_64-darwin" selon ton architecture
      linuxSystem = "x86_64-linux";   # Pour WSL NixOS
    in {
      # Configuration macOS avec nix-darwin
      darwinConfigurations."JP4N99N4TV" = darwin.lib.darwinSystem {
        system = darwinSystem;
        specialArgs = { inherit nix-colors nixvim; };
        modules = [
          ./darwin-configuration.nix
          nix-colors.homeManagerModule
          home-manager.darwinModules.home-manager
        ];
      };

      # Configuration WSL NixOS
      nixosConfigurations."nixos-wsl" = nixpkgs.lib.nixosSystem {
        system = linuxSystem;
        specialArgs = { inherit nix-colors nixvim; };
        modules = [
          ./nixos-configuration.nix
          home-manager.nixosModules.home-manager
        ];
      };
    };
}
