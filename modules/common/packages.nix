{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    btop
    jq
    neofetch
    neovim
    ripgrep
    tmux
    wget
    yq
  ];
}
