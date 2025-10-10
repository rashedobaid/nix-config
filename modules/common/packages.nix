{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    azure-cli
    awscli2
    btop
    discord
    docker
    docker-compose
    docker-credential-helpers
    gh
    jetbrains.idea-community
    neofetch
    neovim
    nixpkgs-fmt
    nixfmt-rfc-style
    obsidian
    opentofu
    postman
    python313
    ripgrep
    spotify
    terragrunt
    vscode
    # winbox
    wget
  ];
}
