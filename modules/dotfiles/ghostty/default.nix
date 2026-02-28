{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;
    settings = {
      theme = "Nord";
      font-size = 12;
      font-family = "JetBrainsMono Nerd Font Mono";
      command = "/run/current-system/sw/bin/tmux";
      adjust-cell-height = "25%";
      font-thicken = true;
      shell-integration-features = "ssh-terminfo";
    };
  };}
