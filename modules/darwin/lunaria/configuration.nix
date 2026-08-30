{ pkgs, ... }: {
  system.primaryUser = "rashedobaid";
  environment.shellInit = ''
    ulimit -n 2048
  '';
  environment.systemPackages = with pkgs; [
    ansible
    ansible-lint
    azure-cli
    awscli2
    colima
    docker
    docker-compose
    docker-buildx
    docker-credential-helpers
    helm-docs
    gh
    google-cloud-sdk
    iperf3
    kubectl
    kubernetes-helm
    kustomize
    nixfmt
    nixpkgs-fmt
    nodejs
    opentofu
    pre-commit
    pipx
    raycast
    rectangle
    spotify
    terragrunt
    terraform-docs
    tflint
    utm
    zed-editor
    zoom-us
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
    enableZshIntegration = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
    casks = [
      "aws-vpn-client"
      "balenaetcher"
      "discord"
      "firefox"
      "google-chrome"
      "hiddenbar"
      "linearmouse"
      "monitorcontrol"
      "notion"
      "obs"
      "telegram"
      "trezor-suite"
      "viber"
      "vlc"
    ];
    brews = [
      "checkov"
      "mas"
    ];
    masApps = {
      AmorphousDiskMark = 1168254295;
      WireGuard = 1451685025;
    };
  };
}
