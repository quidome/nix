{ config, pkgs, lib, ... }: 

with lib;
{ 
  config = mkIf (config.desktop != "none") {
    services.xserver = {
      enable = true;
      layout = "us";
      libinput.enable = true;
    };
  };
}
