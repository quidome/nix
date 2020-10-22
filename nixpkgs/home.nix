{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "quidome";
  home.homeDirectory = "/home/quidome";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.03";

  home.packages = with pkgs; [
    rcm
    tmux
    ldns
    jq
    yq
    gitAndTools.gitflow
    fzf
    exa
    gopass
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs = {
    bat.enable = true;

    rofi.enable = true;
    rofi.theme = "Pop-Dark.rasi";

    #zsh.enable = true;

    neovim = {
      enable = true;
      vimAlias = true;
      extraConfig = builtins.readFile ./files/extraConfig.vim;

      plugins = with pkgs.vimPlugins; [
        vim-nix
        gruvbox
        nerdtree
        rainbow
        vim-gitgutter
        vim-airline
        vim-airline-themes
        vim-go
        vim-puppet
        tabular
        nerdtree
        vim-fugitive
        vim-dirdiff
      ];
    };
  };

  services = {
    gpg-agent.enableSshSupport = true;
  };
}
