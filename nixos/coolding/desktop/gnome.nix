{ config, pkgs, lib, ... }:


with lib;
{
  config = mkIf (config.desktop == "gnome") {

    # use gdm and gnome-shell
    services.xserver = {
      displayManager.gdm.enable = true;
      displayManager.gdm.wayland = false;
      desktopManager.gnome3.enable = true;
    };

    programs.gnupg.agent.pinentryFlavor = "gnome3";

    # add extra packages to this desktop setup
    environment = {
      # add some desktop applications
      systemPackages = with pkgs; [
        numix-gtk-theme
        numix-icon-theme-circle
        arc-icon-theme
        arc-theme
        gnomeExtensions.dash-to-dock
        gnome3.gnome-tweaks
      ];

      # GTK3 global theme (widget and icon theme)
      etc."xdg/gtk-3.0/settings.ini" = {
        text = ''
          [Settings]
          gtk-icon-theme-name=Arc
          gtk-theme-name=Arc-dark
          gtk-application-prefer-dark-theme = true
        '';
      };
    };
  };
}
