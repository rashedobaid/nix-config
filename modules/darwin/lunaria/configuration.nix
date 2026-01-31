{ pkgs, ... }: {
  system.primaryUser = "rashedobaid";
  environment.shellInit = ''
    ulimit -n 2048
  '';
  environment.systemPackages = with pkgs; [
    alt-tab-macos
    azure-cli
    awscli2
    colima
    discord
    docker
    docker-compose
    docker-credential-helpers
    gh
    iperf3
    maven
    nixfmt
    nixpkgs-fmt
    nodejs
    nodePackages.npm
    opentofu
    pre-commit
    postman
    raycast
    rectangle
    slack
    spotify
    terragrunt
    terraform-docs
    vscode
    # winbox
    utm
    (python313.withPackages (
      ps: with ps; [
        pip
        jmespath
        requests
        setuptools
        pyyaml
        pyopenssl
      ]
    ))
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
      "intellij-idea"
      "linearmouse"
      "monitorcontrol"
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
