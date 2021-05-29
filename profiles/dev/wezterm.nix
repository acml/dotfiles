{ config, pkgs, lib, ... }:

let
  inherit (pkgs.stdenv.targetPlatform) isDarwin isLinux;
  # defaultFont = "DejaVu Sans Mono";
  # defaultFont = if isDarwin then "SFMono" else "Iosevka";
  defaultFontSize = 14.0;
in {
  my.home = { ... }: {
    home.packages = with pkgs; [ wezterm ];
    xdg = {
      enable = true;
      configFile."wezterm/wezterm.lua" = {
        text = ''
          local wezterm = require 'wezterm';

          wezterm.on("update-right-status", function(window, pane)
            -- Each element holds the text for a cell in a "powerline" style << fade
            local cells = {};

            -- Figure out the cwd and host of the current pane.
            -- This will pick up the hostname for the remote host if your
            -- shell is using OSC 7 on the remote host.
            local cwd_uri = pane:get_current_working_dir()
            if cwd_uri then
              cwd_uri = cwd_uri:sub(8);
              local slash = cwd_uri:find("/")
              local cwd = ""
              local hostname = ""
              if slash then
                hostname = cwd_uri:sub(1, slash-1)
                -- Remove the domain name portion of the hostname
                local dot = hostname:find("[.]")
                if dot then
                  hostname = hostname:sub(1, dot-1)
                end
                -- and extract the cwd from the uri
                cwd = cwd_uri:sub(slash)

                table.insert(cells, cwd);
                table.insert(cells, hostname);
              end
            end

            -- I like my date/time in this style: "Wed Mar 3 08:14"
            local date = wezterm.strftime("%a %b %-d %H:%M");
            table.insert(cells, date);

            -- An entry for each battery (typically 0 or 1 battery)
            for _, b in ipairs(wezterm.battery_info()) do
              table.insert(cells, string.format("%.0f%%", b.state_of_charge * 100))
            end

            -- The powerline < symbol
            local LEFT_ARROW = utf8.char(0xe0b3);
            -- The filled in variant of the < symbol
            local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

            -- Color palette for the backgrounds of each cell
            local colors = {
              "#3c1361",
              "#52307c",
              "#663a82",
              "#7c5295",
              "#b491c8",
            };

            -- Foreground color for the text across the fade
            local text_fg = "#c0c0c0";

            -- The elements to be formatted
            local elements = {};
            -- How many cells have been formatted
            local num_cells = 0;

            -- Translate a cell into elements
            function push(text, is_last)
              local cell_no = num_cells + 1
              table.insert(elements, {Foreground={Color=text_fg}})
              table.insert(elements, {Background={Color=colors[cell_no]}})
              table.insert(elements, {Text=" "..text.." "})
              if not is_last then
                table.insert(elements, {Foreground={Color=colors[cell_no+1]}})
                table.insert(elements, {Text=SOLID_LEFT_ARROW})
              end
              num_cells = num_cells + 1
            end

            while #cells > 0 do
              local cell = table.remove(cells, 1)
              push(cell, #cells == 0)
            end

            window:set_right_status(wezterm.format(elements));
          end);

          -- function font_with_fallback(name, params)
          --     local names = {name, "Noto Color Emoji", "Apple Color Emoji"}
          --     return wezterm.font_with_fallback(names, params)
          -- end

          return {
            -- OpenGL for GPU acceleration, Software for CPU
            front_end = "OpenGL",

            -- No updates, bleeding edge only
            check_for_updates = false,

            color_scheme = "Gruvbox Dark",

            -- font = wezterm.font("Iosevka Term Nerd Font Complete Mono"),
            -- Font Stuff
            -- font = font_with_fallback("IosevkaNerdFontCompleteM-Term"),
            -- font_rules = {
            --   {
            --     italic = true,
            --     font = font_with_fallback("IosevkaNerdFontCompleteM-Italic", {italic = true})
            --   }, {
            --     italic = true,
            --     intensity = "Bold",
            --     font = font_with_fallback("IosevkaNerdFontCompleteM-Bold-Italic",
            --                               {bold = true, italic = true})
            --      },
            --   {
            --     intensity = "Bold",
            --     font = font_with_fallback("IosevkaNerdFontCompleteM-Bold", {bold = true})
            --   },
            --   {intensity = "Half", font = font_with_fallback("IosevkaNerdFontCompleteM-Light")}
            -- },
            font_size = 13.0,
            font_shaper = "Harfbuzz",
            line_height = 1.0,
            freetype_load_target = "HorizontalLcd",
            freetype_render_target = "Normal",

            -- Cursor style
            -- default_cursor_style = "SteadyUnderline",

            -- X Bad
            enable_wayland = false,

            -- Pretty Colors
            bold_brightens_ansi_colors = true,

            -- Get rid of close prompt
            window_close_confirmation = "NeverPrompt",

            hide_tab_bar_if_only_one_tab = true,
            adjust_window_size_when_changing_font_size = false,
          }
        '';
      };
    };
  };
}
