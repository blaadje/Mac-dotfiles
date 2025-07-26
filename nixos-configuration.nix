{ config, pkgs, lib, nix-colors, nixvim, ... }:

{
  # Configuration de base NixOS/WSL
  boot.isContainer = true;  # WSL est un container
  
  # Configuration minimal pour WSL
  fileSystems."/" = { device = "/dev/disk/by-label/nixos"; fsType = "ext4"; };
  boot.loader.grub.enable = false;

  # User configuration
  users.users.alexandre = {
    isNormalUser = true;
    description = "Alexandre Charlot";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.fish;
  };

  # Utiliser Home Manager pour la config utilisateur (réutilise common/)
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.alexandre = { lib, ... }: {
      imports = [
        nix-colors.homeManagerModules.default
        nixvim.homeManagerModules.nixvim
        (import ./nix/common/packages.nix {
          inherit config pkgs lib;
          fontConfig = {
            family = "MesloLGL Nerd Font";
            size = "15";
            package = pkgs.nerd-fonts.meslo-lg;
          };
        })
        (import ./nix/linux/packages.nix { inherit config pkgs lib; })
        (import ./nix/linux/services.nix { inherit config pkgs lib; })
      ];

      home = {
        username = "alexandre";
        homeDirectory = "/home/alexandre";
        stateVersion = "23.11";
      };

      # Schéma de couleurs
      colorScheme = nix-colors.colorSchemes.catppuccin-frappe;

      fonts = { fontconfig.enable = true; };

      home.sessionVariables = {
        PATH =
          "$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH";
      };

      programs.home-manager.enable = true;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable programs au niveau système
  programs = {
    fish.enable = true;
    git.enable = true;
    bash.enable = true;  # Nécessaire pour WSL
  };

  # Packages système essentiels pour WSL
  environment.systemPackages = with pkgs; [
    bash  # WSL a besoin de bash
    coreutils
    util-linux
  ];

  # System configuration
  system.stateVersion = "23.11";

  # Enable nix flakes
  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Basic system settings
  networking.hostName = "nixos-wsl";
  time.timeZone = "Europe/Paris";
}
