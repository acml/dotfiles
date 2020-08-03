{ config, lib, pkgs, ... }:

let
  mkSwaybar = { outputs, id ? null }: {
    id = id;
    position = "top";
    mode = "dock";
    statusCommand = "while date +'%Y-%m-%d %l:%M:%S %p'; do sleep 1; done";
    trayOutput = "none";
    fonts = [ "FontAwesome 10" "Terminus 10" ];
    colors = {
      statusline = "#FFFFFF";
      background = "#323232";
      inactiveWorkspace = { border = "#000000"; background = "#5c5c5c"; text = "#FFFFFF"; };
    };
    extraConfig = lib.concatMapStringsSep "\n" (x: "output \"${x}\"") outputs;
  };

  mkCommand = commands: lib.concatStringsSep "; \\\n" commands;

  mkFloatingNoBorder = { criteria, extraCommands ? [] }: {
    inherit criteria;
    command = mkCommand ([ "floating enable" "border none" ] ++ extraCommands);
  };

  mkFloatingSticky = criteria: {
    inherit criteria;
    command = mkCommand [ "floating enable" "sticky enable" ];
  };

  mkInhibitFullscreen = criteria: {
    inherit criteria;
    command = "inhibit_idle fullscreen";
  };

  mkMarkSocial = name: criteria: {
    inherit criteria;
    command = "mark \"_social_${name}\"";
  };

  # Primary outputs
  OUTPUT-HOME-DELL-RIGHT = "Dell Inc. DELL U2414H R9F1P56N68VL";
  OUTPUT-HOME-DELL-LEFT  = "Dell Inc. DELL U2414H R9F1P55S45FL";
  OUTPUT-HOME-BENQ = "Unknown BenQ EW3270U 74J08749019";
  OUTPUT-HOME-DELL = "Dell Inc. DELL U3219Q F9WNWP2";
  OUTPUT-LAPTOP = "eDP-1";

  # Sway variables
  imageFolder = toString config.programs.swaylock.imageFolder;

  binaries = rec {
    terminal = "${alacritty} --working-directory ${config.home.homeDirectory}";
    floating-term = "${terminal} --class='floating-term'";
    explorer = "${nautilus}";
    browser = "${pkgs.writeScriptBin "firefox" ''
      export MOZ_DBUS_REMOTE=1
      export MOZ_ENABLE_WAYLAND=1
      ${firefox}
    ''}/bin/firefox";
    browser-private = "${browser} --private-window";
    lock = "${swaylock} -f -c 0f0f0ff0 -i ${imageFolder}/3840x2160.png";
    logout-menu = "${wlogout}";
    audiocontrol = "${pavucontrol}";
    menu = "${xfce4-appfinder} --replace";
    menu-wofi = "${wofi} --fork --show drun,run";

    alacritty = "${pkgs.alacritty}/bin/alacritty";
    bitwarden = "${pkgs.bitwarden}/bin/bitwarden";
    brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
    # Firefox from the overlay
    firefox = "${pkgs.firefox}/bin/firefox";
    nautilus = "${pkgs.gnome3.nautilus}/bin/nautilus";
    pavucontrol = "${pkgs.pavucontrol}/bin/pavucontrol";
    playerctl = "${pkgs.playerctl}/bin/playerctl";
    element-desktop = "${pkgs.element-desktop}/bin/element-desktop";
    spotify = "${pkgs.spotify}/bin/spotify";
    swaylock = "${pkgs.swaylock}/bin/swaylock";
    swaymsg = "${config.wayland.windowManager.sway.package}/bin/swaymsg";
    wl-paste = "${pkgs.wl-clipboard}/bin/wl-paste";
    wlogout = "${pkgs.wlogout}/bin/wlogout";
    wofi = "${pkgs.wofi}/bin/wofi";
    xfce4-appfinder = "${pkgs.xfce.xfce4-appfinder}/bin/xfce4-appfinder";
  };

  WS1 = "1: browsing";
  WS2 = "2: school";
  WS3 = "3: dev";
  WS4 = "4: sysadmin";
  WS5 = "5: gaming";
  WS6 = "6: movie";
  WS7 = "7: social";
  WS8 = "8: random";
  WS9 = "9: random";
  WS10 = "10: random";

  extraConfig = let
    makeCommand = (i: x: "exec ${binaries.swaymsg} rename workspace number ${toString i} to '${x}'");
    workspaces = [ WS1 WS2 WS3 WS4 WS5 WS6 WS7 WS8 WS9 WS10 ];
  in ''
    ${lib.concatImapStringsSep "\n" (makeCommand) workspaces}

    hide_edge_borders --i3 smart_no_gaps

    # Set default workspace outputs
    workspace "${WS5}" output "${OUTPUT-HOME-DELL}" "${OUTPUT-HOME-BENQ}" "${OUTPUT-LAPTOP}"
    workspace "${WS6}" output "${OUTPUT-HOME-DELL}" "${OUTPUT-HOME-BENQ}" "${OUTPUT-LAPTOP}"
    workspace "${WS7}" output "${OUTPUT-HOME-DELL-RIGHT}" "${OUTPUT-HOME-DELL-LEFT}"

    # Enable/Disable the output when closing the lid (e.g. when using a dock)
    bindswitch --locked lid:on  output ${OUTPUT-LAPTOP} disable
    bindswitch --locked lid:off output ${OUTPUT-LAPTOP} enable
  '';

  swayConfig = lib.mkMerge [
    {
      inherit (binaries) terminal;
      modifier = "Mod4";
      floating.modifier = "Mod4";
      menu = binaries.menu-wofi;

      fonts = [ "FontAwesome 9" "Fira Sans 9" ];

      focus.newWindow = "focus";
      gaps = {
        inner = 5;
        smartGaps = true;
        smartBorders = "no_gaps";
        # Following option needs to be set in extraConfig
        # window.hideEdgeBorders = "smart_no_gaps";
      };
      window = {
        titlebar = true;
        border = 3;
      };
      floating = {
        titlebar = true;
        border = 1;
      };
      workspaceLayout = "default";
      workspaceAutoBackAndForth = false;

      output = {
        "${OUTPUT-HOME-BENQ}" = { bg = "${imageFolder}/3840x2160.png center"; };
        "${OUTPUT-HOME-DELL-RIGHT}" = { bg = "${imageFolder}/3840x2160.png center"; };
        "${OUTPUT-HOME-DELL-LEFT}"  = { bg = "${imageFolder}/3840x2160.png center"; };
        "${OUTPUT-HOME-DELL}" = { bg = "${imageFolder}/3840x2160.png center"; };
        "*" = { bg = "${imageFolder}/3840x2160.png center"; };
      };

      input = import ./inputs.nix;

      floating.criteria = [
        { app_id = "floating-term"; }
        { app_id = "org.gnome.Nautilus"; }
        { title = "feh.*/Pictures/screenshots/.*"; }
        { app_id = "firefox"; title = "Developer Tools"; }
      ];

      startup = [
        { command = binaries.element-desktop; }
        { command = binaries.spotify; }
        { command = binaries.bitwarden; }
      ];
    }
    {
      keybindings = pkgs.callWithDefaults ./keybindings.nix {
        inherit config binaries;
      };

      modes = pkgs.callWithDefaults ./modes.nix {
        inherit config binaries;
      };
    }
    {
      # Hopefully the windows remain focused without needing to use the focus command
      assigns = {
        # Games related
        "'${WS5}'" = [
          { instance = "Steam"; }
          { app_id = "lutris"; }
        ];
        # Movie related stuff
        "'${WS6}'" = [
          { title = "^Netflix.*"; }
          { title = "^Plex.*"; }
        ];
        # Social stuff
        #"\"${WS7}\"" = [
        #  { con_mark = "_social.*"; }
        #  { con_mark = "_music-player.*"; }
        #];
      };
    }
    {
      window.commands = lib.flatten [
        (map mkInhibitFullscreen [
          { class = "Firefox"; }
          { app_id = "firefox"; }
          { instance = "Steam"; }
          { app_id = "lutris"; }
          { title = "^Zoom Cloud.*"; }
        ])
        (map (x: mkFloatingNoBorder { criteria = x; }) [
          { app_id = "^launcher$"; }
          { app_id = "xfce4-appfinder"; }
          { instance = "xfce4-appfinder"; }
        ])
        (mkFloatingNoBorder {
          criteria = { app_id = "blueman-manager"; };
          extraCommands = [ "scratchpad move" "scratchpad show" ];
        })
        (map mkFloatingSticky [
          { app_id = "pavucontrol"; }
          { app_id = "gnome-calendar"; }
        ])
        {
          criteria = { class = "Spotify"; instance = "spotify"; };
          command = "mark --add _music-player.spotify";
        }
        (mkMarkSocial "element" { class = "Element"; })
        (mkMarkSocial "bitwarden" { class = "Bitwarden"; })
        (mkMarkSocial "rocket" { class = "Rocket.Chat"; })
        (mkMarkSocial "caprine" { class = "Caprine"; })
        # assing [con_mark] does not work! So we do it here with a for_window
        (map (x: { command = "move to workspace number 7"; criteria = x; }) [
          { con_mark = "_social.*"; }
          { con_mark = "_music-player.*"; }
        ])
      ];
    }
    # {
    #   bars = [(mkSwaybar {
    #     id = "secondary-top";
    #     outputs = [ OUTPUT-HOME-DELL-RIGHT OUTPUT-HOME-DELL-LEFT ];
    #   })];
    # }
  ];
in
{
  inherit extraConfig;
  config = swayConfig;
}
