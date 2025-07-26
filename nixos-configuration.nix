{ config, pkgs, lib, nix-colors, nixvim, ... }:

{
  # Configuration minimale requise pour NixOS
  boot.loader.grub.enable = false;
  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
  };

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

  # CRITIQUE : Créer les liens symboliques nécessaires pour WSL
  system.activationScripts.wslCompat = ''
    # Créer /bin/bash pour WSL
    mkdir -p /bin
    ln -sf /run/current-system/sw/bin/bash /bin/bash
    
    # S'assurer que bash est dans le PATH
    ln -sf /run/current-system/sw/bin/bash /usr/bin/bash || true
  '';
}
