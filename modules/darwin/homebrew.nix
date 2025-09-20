{ ... }: {
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    caskArgs.no_quarantine = true;
    brews = [
      "mas"
    ];
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
    masApps = {
      WireGuard = 1451685025;
    };
  };
}
