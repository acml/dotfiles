{ config, pkgs, lib, ... }:

let
  inherit (pkgs.stdenv.targetPlatform) isDarwin isLinux;
  # defaultFont = "DejaVu Sans Mono";
  # defaultFont = if isDarwin then "SFMono" else "Iosevka";
  defaultFontSize = 14.0;
in {
  my.home = { ... }: {
    programs.kitty = {
      enable = true;

      # font.name = "JetBrainsMono Nerd Font Mono";
      # font.name = "FantasqueSansMono Nerd Font Mono";
      font.name = "Fira Code";

      settings = {
        bold_font = "auto";
        italic_font = "auto";
        bold_italic_font = "auto";

        font_size = "13.0";

        scrollback_lines = "10000";

        macos_adjust_glyph_scale = "0.05";
        macos_adjust_glyph_y = "-4.0";
        macos_adjust_glyph_x = "-1.0";

        # onedark
        # cursor = "#cccccc";

        # foreground = "#eeeeee";
        # background = "#282828";

        # color0 = "#282828";
        # color8 = "#484848";
        # color1 = "#f43753";
        # color9 = "#f43753";
        # color2  = "#c9d05c";
        # color10 = "#c9d05c";
        # color3  = "#ffc24b";
        # color11 = "#ffc24b";
        # color4  = "#b3deef";
        # color12 = "#b3deef";
        # color5  = "#d3b987";
        # color13 = "#d3b987";
        # color6  = "#73cef4";
        # color14 = "#73cef4";
        # color7  = "#eeeeee";
        # color15 = "#ffffff";

        # active_tab_foreground   = "#282828";
        # active_tab_background   = "#bbbbbb";
        # active_tab_font_style   = "bold";
        # inactive_tab_foreground = "#eeeeee";
        # inactive_tab_background = "#282828";
        # inactive_tab_font_style = "normal";

        # # selection_foreground = "#282c34";
        # # selection_background = "#979eab";

        # gruvbox dark
        background = "#282828";
        foreground = "#ebdbb2";

        cursor = "#928374";

        selection_foreground = "#928374";
        selection_background = "#3c3836";

        color0 = "#282828";
        color8 = "#928374";

        color1 = "#cc241d";
        color9 = "#fb4934";

        color2 = "#98971a";
        color10 = "#b8bb26";

        color3 = "#d79921";
        color11 = "#fabd2d";

        color4 = "#458588";
        color12 = "#83a598";

        color5 = "#b16286";
        color13 = "#d3869b";

        color6 = "#689d6a";
        color14 = "#8ec07c";

        color7 = "#a89984";
        color15 = "#928374";

        # gruvbox light
        # background  = "#fbf1c7";
        # foreground  = "#3c3836";

        # cursor                = "#928374";

        # selection_foreground  = "#3c3836";
        # selection_background  = "#928374";

        # color0  = "#fbf1c7";
        # color8  = "#282828";

        # color1                = "#cc241d";
        # color9                = "#9d0006";

        # color2                = "#98971a";
        # color10               = "#79740e";

        # color3                = "#d79921";
        # color11               = "#b57614";

        # color4                = "#458588";
        # color12               = "#076678";

        # color5                = "#b16286";
        # color13               = "#8f3f71";

        # color6                = "#689d6a";
        # color14               = "#427b58";

        # color7                = "#7c6f64";
        # color15               = "#928374";
      };

      # keybindings = {
      #   "ctrl+insert" = "copy_to_clipboard";
      #   "shift+insert" =    "paste_from_clipboard";

      #   "ctrl+enter"  =       "new_window";
      #   "ctrl+backspace"  =   "close_window";
      #   "ctrl+delete"  =      "close_window";
      #   "ctrl+pagedown"  =    "next_window";
      #   "ctrl+pageup"  =      "previous_window";

      #   "ctrl+f" =           "goto_layout stack";
      #   "ctrl+escape" =      "last_used_layout";

      #   "alt+enter" =         "new_tab";
      #   "alt+backspace" =     "close_tab";
      #   "alt+delete" =        "close_tab";
      #   "alt+pagedown" =      "next_tab";
      #   "alt+pageup" =        "previous_tab";
      # };
    };
  };
}
