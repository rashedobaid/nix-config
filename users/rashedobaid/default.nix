{ config, pkgs, ... }:
{
  home = {
    username = "rashedobaid";
    stateVersion = "25.05";
  };
  imports = [
    ../../modules/dotfiles/ghostty/default.nix
    ../../modules/dotfiles/git/default.nix
    ../../modules/dotfiles/linearmouse/default.nix
    ../../modules/dotfiles/neofetch/default.nix
    ../../modules/dotfiles/zsh/default.nix
  ];
}