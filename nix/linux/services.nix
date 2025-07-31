{ config, pkgs, lib, ... }:

{
  # Services spécifiques à Linux (WSL)
  # Configuration minimaliste pour WSL - pas de window manager nécessaire

  systemd.user.services.colemak-layout = {
    Unit = {
      Description = "Configure Colemak keyboard layout for X11";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart =
        "${pkgs.xorg.setxkbmap}/bin/setxkbmap us -variant colemak -option caps:backspace";
      Environment = "DISPLAY=:0";

    };
    Install = { WantedBy = [ "graphical-session.target" ]; };
  };
}
