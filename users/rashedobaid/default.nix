{ ... }:
let 
  home = {
    username = "rashedobaid";
    stateVersion = "25.05";
  };
in 
{
  home = home;

  imports = [
    ../../modules/dotfiles/ghostty/default.nix
    ../../modules/dotfiles/linearmouse/default.nix
    ../../modules/dotfiles/neofetch/default.nix
    ../../modules/dotfiles/zsh/default.nix
    ./gitconfig.nix
  ];
}