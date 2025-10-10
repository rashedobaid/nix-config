{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    btop
    neofetch
    neovim
    ripgrep
    wget
  ];
}
