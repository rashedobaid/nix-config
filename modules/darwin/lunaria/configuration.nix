{ pkgs, ... }: {
  system.primaryUser = "rashedobaid";
  environment.shellInit = ''
    ulimit -n 2048
  '';
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
    maven
    nixfmt
    nixpkgs-fmt
    nodejs
    nodePackages.npm
    opentofu
    pre-commit
    postman
    python313
    raycast
    rectangle
    slack
    spotify
    terragrunt
    terraform-docs
    vscode
    # winbox
    utm
  ];
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
      "obs"
      "telegram"
      "trezor-suite"
      "tunnelblick@beta"
      "viber"
      "vlc"
      "zen"
    ];
    brews = [
      "mas"
      "openjdk@11"
    ];
    masApps = {
      AmorphousDiskMark = 1168254295;
      WireGuard = 1451685025;
    };
  };
}
