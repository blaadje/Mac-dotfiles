{
  description = "Nix Darwin System Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:lnl7/nix-darwin";
    nixvim.url = "github:nix-community/nixvim";
    nix-colors.url = "github:misterio77/nix-colors";
    home-manager.url = "github:nix-community/home-manager/master";
    nur.url = "github:nix-community/NUR";

    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, darwin, home-manager, nix-colors, nixvim, nur, ... }:
    let
      darwinSystem =
        "aarch64-darwin"; # ou "x86_64-darwin" selon ton architecture
      linuxSystem = "x86_64-linux"; # Pour WSL NixOS
      
      # Configure NUR overlay
      pkgsWithNur = system: import nixpkgs {
        inherit system;
        overlays = [ nur.overlays.default ];
        config = {};
      };
    in {
      # Configuration macOS avec nix-darwin
      darwinConfigurations."JP4N99N4TV" = darwin.lib.darwinSystem {
        system = darwinSystem;
        specialArgs = { 
          inherit nix-colors nixvim; 
          # Use NUR legacyPackages with allowUnfree
          nurpkgs = import nur { 
            pkgs = import nixpkgs { 
              system = darwinSystem; 
              config.allowUnfree = true; 
            };
            nurpkgs = import nixpkgs { 
              system = darwinSystem; 
              config.allowUnfree = true; 
            };
          };
        };
        modules = [
          ./darwin-configuration.nix
          nix-colors.homeManagerModule  
          home-manager.darwinModules.home-manager
        ];
      };

      # Configuration Debian avec Home Manager standalone
      homeConfigurations."aukx@debian" =
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${linuxSystem};
          extraSpecialArgs = { 
            inherit nix-colors nixvim; 
            # Use NUR legacyPackages with allowUnfree for Debian too
            nurpkgs = import nur { 
              pkgs = import nixpkgs { 
                system = linuxSystem; 
                config.allowUnfree = true; 
              };
              nurpkgs = import nixpkgs { 
                system = linuxSystem; 
                config.allowUnfree = true; 
              };
            };
          };
          modules = [ ./debian-home.nix ];
        };
    };
}
