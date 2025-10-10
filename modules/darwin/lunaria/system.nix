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
    };
    finder = {
      FXDefaultSearchScope = "SCcf";
      AppleShowAllExtensions = true;
      FXEnableExtensionChangeWarning = false;
      ShowStatusBar = true;
    };
    dock = {
      tilesize = 35;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.4;
    };
    NSGlobalDomain = {
      "com.apple.sound.beep.volume" = 0.0;
      InitialKeyRepeat = 13;
      KeyRepeat = 2;
    };
  };

  system.activationScripts.restartDock.text = ''
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    launchctl stop com.apple.Dock.agent || true
    launchctl start com.apple.Dock.agent || true
  '';
}
