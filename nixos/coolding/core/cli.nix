{ config, pkgs, ... }:

{
  # Basic command line setup
  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    systemPackages = with pkgs; [
      # the core essentials
      vim
      htop
      git

      # network
      openconnect
      rdesktop
      wget
      curl

      # handy tools
      bat
      exa
      httpie
      ripgrep
      fzf

      # cloud stuff
      k9s
      kubectl
      kubectx
      stern
    ];
  };
}
