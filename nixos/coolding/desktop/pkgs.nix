{ config, pkgs, lib, ... }:

with lib;
{
  environment.systemPackages =
    if config.services.xserver.enable then with pkgs; [
      # web
      firefox
      chromium

      # dev
      meld
      vscode
      emacs
      go
      vagrant

      # orchestration
      ansible

      # messaging
      riot-desktop
      tdesktop
      signal-desktop
      teams     # ms teams

      # multimedia
      spotify
    ]
    else
      [ ];
}
