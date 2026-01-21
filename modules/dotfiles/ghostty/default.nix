{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;
    settings = {
      theme = "TokyoNight Night";
      font-size = 12;
      font-family = "JetBrainsMono Nerd Font Mono";
      adjust-cell-height = "25%";
      font-thicken = true;
      shell-integration-features = "ssh-terminfo";
    };
  };}
