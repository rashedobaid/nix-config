{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    btop
    jq
    neofetch
    neovim
    ripgrep
    tmux
    tree
    wget
    yq
  ];
}
