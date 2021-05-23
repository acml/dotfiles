{ config, pkgs, lib, ... }:

let
  inherit (pkgs.stdenv.targetPlatform) isDarwin isLinux;
  # defaultFont = "DejaVu Sans Mono";
  # defaultFont = if isDarwin then "SFMono" else "Iosevka";
  defaultFontSize = 14.0;
in
{
  my.home = { ... }: {
    programs.kitty.enable = true;
    # programs.kitty.font.name = "SauceCodePro Nerd Font Mono";
    programs.kitty.settings = {
      font_family      = "SauceCodePro Nerd Font Mono";
      bold_font        = "auto";
      italic_font      = "auto";
      bold_italic_font = "auto";

      font_size = "14.0";

      # background            = "#000000";
      # foreground            = "#e9e9e9";
      # cursor                = "#e9e9e9";
      # selection_background  = "#424242";
      # color0                = "#000000";
      # color8                = "#000000";
      # color1                = "#d44d53";
      # color9                = "#d44d53";
      # color2                = "#b9c949";
      # color10               = "#b9c949";
      # color3                = "#e6c446";
      # color11               = "#e6c446";
      # color4                = "#79a6da";
      # color12               = "#79a6da";
      # color5                = "#c396d7";
      # color13               = "#c396d7";
      # color6                = "#70c0b1";
      # color14               = "#70c0b1";
      # color7                = "#fffefe";
      # color15               = "#fffefe";
      # selection_foreground  = "#000000";

      background  = "#282828";
      foreground  = "#ebdbb2";

      cursor                = "#928374";

      selection_foreground  = "#928374";
      selection_background  = "#3c3836";

      color0  = "#282828";
      color8  = "#928374";

      # red
      color1                = "#cc241d";
      # light red
      color9                = "#fb4934";

      # green
      color2                = "#98971a";
      # light green
      color10               = "#b8bb26";

      # yellow
      color3                = "#d79921";
      # light yellow
      color11               = "#fabd2d";

      # blue
      color4                = "#458588";
      # light blue
      color12               = "#83a598";

      # magenta
      color5                = "#b16286";
      # light magenta
      color13               = "#d3869b";

      # cyan
      color6                = "#689d6a";
      # lighy cyan
      color14               = "#8ec07c";

      # light gray
      color7                = "#a89984";
      # dark gray
      color15               = "#928374";
    };
  };
}
