{ config, pkgs, ... }:

{
  # disable generic dhcp
  networking.useDHCP = false;

  # set to true for wpa supplicant
  networking.wireless.enable = true;
  networking.interfaces.enp1s0f0.useDHCP = true;
  networking.interfaces.wlp2s0.useDHCP = true;

  # set to true for networkmanager
  networking.networkmanager.enable = false;
}
