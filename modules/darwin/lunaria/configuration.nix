{ pkgs, ... }: {
  system.primaryUser = "rashedobaid";
  environment.shellInit = ''
    ulimit -n 2048
  '';
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    caskArgs = {
      no_quarantine = true;
    };
    casks = [
      "aws-vpn-client"
      "balenaetcher"
      "firefox"
      "google-chrome"
      "hiddenbar"
      "linearmouse"
      "notion"
      "telegram"
      "tunnelblick@beta"
      "viber"
      "zen"
    ];
    brews = [
      "mas"
    ];
    masApps = {
      WireGuard = 1451685025;
    };
  };
  environment.systemPackages = with pkgs; [
    alt-tab-macos
    azure-cli
    awscli2
    betterdisplay
    colima
    discord
    docker
    docker-compose
    docker-credential-helpers
    gh
    iperf3
    jetbrains.idea-community
    nixpkgs-fmt
    nixfmt-rfc-style
    obsidian
    opentofu
    pre-commit
    postman
    python313
    raycast
    rectangle
    spotify
    terragrunt
    vscode
    # winbox
    utm
  ];
}
