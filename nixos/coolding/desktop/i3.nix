{ config, pkgs, lib, ... }:


with lib;
{
  config = mkIf (config.desktop == "i3") {
    # i3 related hardware configuration
    hardware = {
      pulseaudio.enable = true;

      bluetooth.enable = true;
      bluetooth.powerOnBoot = true;
    };

    # enable xserver but use startx instead of a DM
    services = {
      xserver = {
        enable = true;
        desktopManager.xterm.enable = false;
        displayManager.startx.enable = true;
        xkbOptions = "terminate:ctrl_alt_bksp,caps:none,altwin:swap_lalt_lwin";

        # install i3 plus supporting packages
        windowManager.i3 = {
          enable = true;
          extraPackages = with pkgs; [
            dmenu
            i3status-rust
            i3lock
            termite
            xss-lock
            pavucontrol
            pamixer
            playerctl        # control media
            brightnessctl    # control screen backlight
          ];
        };
      };
    };

    fonts.fonts = with pkgs; [
      source-code-pro
      font-awesome
    ];
  };
}
