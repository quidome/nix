{ config, pkgs, lib, ... }:


with lib;
{
  config = mkIf (config.desktop == "kde") {

    # 
    hardware.pulseaudio.enable = true;

    # use gdm and gnome-shell
    services.xserver = {
      displayManager.sddm.enable = true;
      displayManager.sddm.theme = "breeze";
      displayManager.defaultSession = "plasma5";
      desktopManager.plasma5.enable = true;
    };

    programs.gnupg.agent.pinentryFlavor = "qt";

    # add extra packages to this desktop setup
    environment = {
      # add some desktop applications
      systemPackages = with pkgs; [
        # kde apps
        #konsole
        # okular
        # yakuake
        # bluedevil
        # kdeApplications.spectacle
        # kate
        # ark
        #kdeplasma-addons

        # # gnupg
        # kgpg
        # pinentry-qt

        # # Password manager for KDE
        # kdeFrameworks.kwallet
        # kdeApplications.kwalletmanager
        # kwalletcli

        # # Printing and scanning
        # kdeApplications.print-manager
        # simple-scan
      ];
    };
  };
}
