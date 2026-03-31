{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    btop
    jq
    neovim
    ripgrep
    tmux
    tree
    wget
    yq
  ];
}
