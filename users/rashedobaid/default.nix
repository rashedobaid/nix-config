{ config, pkgs, ... }:
{
  home = {
    username = "rashedobaid";
    stateVersion = "25.05";
  };
  imports = [
    ../../modules/dotfiles/git/default.nix
    ../../modules/dotfiles/kitty/default.nix
    ../../modules/dotfiles/linearmouse/default.nix
    ../../modules/dotfiles/neofetch/default.nix
    ../../modules/dotfiles/zsh/default.nix

    # ../../modules/dotfiles/git/work.nix
  ];
}