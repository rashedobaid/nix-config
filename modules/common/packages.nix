{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    btop
    jq
    neofetch
    neovim
    ripgrep
    wget
    yq
  ];
}
