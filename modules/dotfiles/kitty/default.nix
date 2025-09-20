{
  programs.kitty = {
    enable = true;
    themeFile = "tokyo_night_night";
    font = {
      name = "JetBrainsMono Nerd Font Mono";
      size = 12;
    };
    shellIntegration = {
      enableZshIntegration = true;
    };
    settings = {
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      tab_title_template = "{index}: {title[title.rfind('/')+1:]}";
      adjust_line_height = "120%";
      macos_titlebar_color = "#1A1B26";
      window_padding_width = 0;
      window_margin_width = 0;
    };
  };
}
