{ config, pkgs, ... }:

{
  imports = [
    ./options.nix
    ./net.nix
    ./cli.nix
  ];
}
