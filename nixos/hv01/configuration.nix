# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./zfs-configuration.nix
    ./secrets.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "hv01"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;

  networking.interfaces.enp2s0f0.useDHCP = false;
  networking.interfaces.vlan40.useDHCP = false;

  # vlan configuration
  networking.vlans.vlan40.interface = "enp2s0f0";
  networking.vlans.vlan40.id = 40;

  # static ip config 
  networking.interfaces.enp2s0f0.ipv4.addresses = [ { address = "172.16.10.64"; prefixLength = 24; } ];
  networking.interfaces.vlan40.ipv4.addresses = [ { address = "172.16.40.64"; prefixLength = 24; } ];

  # routing and resolving
  networking.defaultGateway = "172.16.40.1";
  networking.nameservers = ["172.16.40.1" "172.16.10.1"];
  networking.search = ["lan.balti.casa" "mgt.balti.casa" "balti.casa"];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IE.UTF-8";

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    emacs-nox
    wget
    vim
    curl
    htop
    git

    # docker stuff
    docker-compose
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # disable firewall
  networking.firewall.enable = false;

  # enable docker + metrics
  virtualisation.docker = {
    enable = true;
    extraOptions = "--experimental --metrics-addr=172.16.10.64:9323";
  };

  # enable prometheus node exporter
  services.prometheus.exporters.node = {
    enable = true;
    openFirewall = true;
    listenAddress = "172.16.10.64";
  };

  # enable cadvisor exporter
  services.cadvisor = {
    enable = true;
    listenAddress = "172.16.10.64";
  };
services.nfs.server.enable = true;
  users.groups.dockergroup.gid = 1001;
  users.users.dockeruser = {
      isSystemUser = true;
      uid = 1001;
      group = "dockergroup";
  }

  # auto upgrade system
  system.autoUpgrade.enable = true;
  system.autoUpgrade.channel = https://nixos.org/channels/nixos-20.03;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}
