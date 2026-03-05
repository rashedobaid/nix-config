{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    btop
    fastfetch
    jq
    neovim
    ripgrep
    tmux
    tree
    wget
    yq
  ];
}
