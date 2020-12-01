{ config, lib, pkgs, ... }:

let
  config1 = {
    layer = "top";
    position = "top";
    #height = 30;
    output = [
      # "eDP-1",
      # "Dell Inc. DELL U3219Q F9WNWP2",
      "DP-2"
      "DP-4"
      "DP-5"
      "DP-1"
    ];

    modules-left = [
      "sway/workspaces"
      "sway/mode"
      "custom/spotify"
    ];
    modules-center = [
      "sway/window"
      # "temperature"
    ];
    modules-right = [
      "idle_inhibitor"
      "pulseaudio"
      "network"
      "cpu"
      "memory"
      "backlight"
      "tray"
      "battery"
      "clock"
    ];

    modules = {
      "sway/workspaces" = {
        disable-scroll = true;

        all-outputs = true;
        format = "<span>{index}</span><span>{icon}</span>";
        format-icons = {
          "1: Browsing" = "<span></span>";
          "3: Dev" = "<span></span>";
          "4: Sysadmin" = "<span></span>";
          "7: Social" = "<span></span>";
          "urgent" = "";
          "focused" = "";
          "default" = "";
        };
      };
      "sway/mode" = {
        format = "<span style=\"italic\">{}</span>";
        tooltip = false;
      };
      "sway/window" = {
        max-length = 120;
        tooltip = false;
      };
      "idle_inhibitor" = {
        format = "{icon}";
        format-icons = {
          activated = "聯";
          deactivated = "輦";
        };
        tooltip = false;
      };
      "tray" = {
        icon-size = 21;
        spacing = 10;
      };
      "clock" = {
        interval = 60;
        format = "{ =%Y-%m-%d | %H =%M}";
        format-alt = "{ =%Y-%m-%d}";
        tooltip = false;
      };
      "cpu" = {
        format = " {usage =2}%";
        tooltip = false;
      };
      "memory" = {
        format = " { =2}%";
        tooltip = false;
      };
      "backlight" = {
        device = "intel_backlight";
        format = "{icon} {percent =2}%";
        format-icons = [
          "ﯦ"
          "ﯧ"
        ];
        tooltip = false;
      };
      "battery" = {
        interval = 30;
        format = "{icon} {capacity =2}%";
        format-icons = [
          ""
          ""
          ""
          ""
          ""
        ];
        states = {
          warning = 25;
          critical = 10;
        };
        tooltip = false;
      };
      "network" = {
        # interface = "wlp2s0"; # (Optional) To force the use of this interface
        format-wifi = "{icon} {ipaddr}/{essid}";
        format-ethernet = "{icon} {ipaddr}/{cidr}";
        format-icons = {
          #"wifi" = [""; "" ;""];
          wifi = [ "" ];
          ethernet = [ "" ];
          disconnected = [ "" ];
        };
        tooltip = "{essid} {ipaddr}/{cidr}";
        on-click = "network-manager";
      };
      "pulseaudio" = {
        scroll-step = "10%";
        format = "{icon} {volume}";
        format-bluetooth = " {volume}";
        format-muted = "婢";
        format-icons = {
          headphones = "";
          headset = "";
          phone = "";
          default = [
            ""
            ""
            ""
          ];
        };
        tooltip = false;
        on-click = "pavucontrol";
      };
      # "temperature" = {
      #   hwmon-path = "/sys/class/hwmon/hwmon3/temp1_input";
      #   // format-icons = [""; ""; ""; ""; ""];
      #   format = "{}";
      # };

      # "custom/spotify" = {
      #   return-type = "json";
      #   interval = 1;
      #   exec = "$HOME/scripts/spotify.sh";
      #   exec-if = "pgrep -c spotify";
      #   escape = true;
      #   on-click = "swaymsg -q '[class=Spotify] focus'";
      #   on-click-right = "playerctl play-pause --player=spotify";
      # }
      "custom/spotify" = {
        return-type = "string";
        tooltip = false;
        format = " {}";
        # Not sure the following line works
        exec = ../../scripts/spotify.py;
        on-click = "swaymsg -q '[class=Spotify] focus'";
        on-click-right = "playerctl play-pause --player=spotify";
      };
    };
  };
in
{
  my.home = { ... }: {
    programs.waybar = {
      enable = true;
      systemd.enable = true;

      #settings = [ config1 ];
      #style = builtins.readFile ./style.css;
    };

    systemd.user.services.waybar = {
      Unit.Requisite = lib.mkForce [ ];
      Unit.After = lib.mkForce [ ];
      Install.WantedBy = lib.mkForce [ "sway-session.target" ];
    };
  };
}
