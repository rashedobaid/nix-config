{
  security.pam.services.sudo_local.touchIdAuth = true;

  environment.launchDaemons."limit.maxfiles.plist" = {
    enable = true;
    text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
      "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>limit.maxfiles</string>
        <key>ProgramArguments</key>
        <array>
          <string>launchctl</string>
          <string>limit</string>
          <string>maxfiles</string>
          <string>524288</string>
          <string>524288</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>ServiceIPC</key>
        <false/>
      </dict>
      </plist>
    '';
  };

  system.defaults = {
    trackpad = {
      Clicking = true;
      TrackpadThreeFingerDrag = true;
      TrackpadTwoFingerFromRightEdgeSwipeGesture = 0;
    };
    finder = {
      FXDefaultSearchScope = "SCcf";
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "Nlsv";
      NewWindowTarget = "Home";
      ShowPathbar = true;
      ShowStatusBar = true;
    };
    dock = {
      tilesize = 35;
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.4;
      launchanim = false;
      mineffect = "scale";
      minimize-to-application = true;
      mru-spaces = false;
      show-recents = false;
      persistent-apps = [
        "/System/Applications/Apps.app"
        "/Applications/Firefox.app"
        "/Applications/Zed.app"
        "/Applications/Obsidian.app"
        "/Applications/Nix Apps/Spotify.app"
      ];
      persistent-others = [ ];
    };
    NSGlobalDomain = {
      "com.apple.sound.beep.volume" = 0.0;
      "com.apple.trackpad.forceClick" = false;
      AppleInterfaceStyle = "Dark";
      AppleKeyboardUIMode = 2;
      AppleReduceDesktopTinting = true;
      AppleSpacesSwitchOnActivate = false;
      AppleWindowTabbingMode = "manual";
      ApplePressAndHoldEnabled = false;
      InitialKeyRepeat = 13;
      KeyRepeat = 2;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticInlinePredictionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSWindowResizeTime = 0.0;
    };
    hitoolbox = {
      AppleFnUsageType = "Do Nothing";
    };
    WindowManager = {
      EnableStandardClickToShowDesktop = false;
      EnableTiledWindowMargins = false;
      EnableTilingByEdgeDrag = false;
      EnableTilingOptionAccelerator = false;
      EnableTopTilingByEdgeDrag = false;
      StandardHideWidgets = true;
    };
    controlcenter = {
      Sound = true;
    };
    universalaccess = {
      reduceMotion = true;
    };
    screencapture = {
      location = "~/Pictures/Screenshots";
    };
    CustomUserPreferences = {
      "com.apple.finder" = {
        FinderSpawnTab = false;
        ShowPreviewPane = true;
        ShowRecentTags = false;
      };
      "com.apple.Spotlight" = {
        EnabledPreferenceRules = [ "System.iphoneApps" ];
      };
    };
  };
}
