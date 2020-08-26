{ config, lib, pkgs, ... }:

lib.mkMerge [
  {
    my.identity.name = "Nicolas Berbiche";
    my.identity.email = "nic." + "berbiche" + "@" + "gmail" + ".com";

    home.sessionVariables = {
      NIX_PAGER = "less --RAW-CONTROL-CHARS --quit-if-one-screen";
    };

    # HomeManager config
    # `man 5 home-configuration.nix`
    manual.manpages.enable = true;

    # XDG
    fonts.fontconfig.enable = lib.mkForce true;

    gtk = {
      enable = true;
      iconTheme = {
        name = "Adwaita";
        # Covered by the theme package below
        # package = pkgs.gnome3.gnome-themes-extra;
      };
      theme = {
        name = "Adwaita";
        package = pkgs.gnome3.gnome-themes-extra;
      };
      gtk2.extraConfig = ''
        gtk-cursor-theme-name="Adwaita"
        gtk-cursor-theme-size="24"
      '';
      gtk3.extraConfig = {
        "gtk-cursor-theme-name" = "Adwaita";
        "gtk-cursor-theme-size" = 24;
      };
    };
    xsession.pointerCursor = {
      package = pkgs.gnome3.gnome-themes-extra;
      name = "Adwaita";
      size = 24;
    };
    xsession.preferStatusNotifierItems = true;

    qt = {
      enable = true;
      platformTheme = "gnome";
    };
    programs.emacs.enable = true;
  }

  (lib.mkIf (builtins.trace ("stdenv.isLinux: ${toString pkgs.stdenv.isLinux}") pkgs.stdenv.isLinux) {
    # Passwords and stuff
    services.gnome-keyring.enable = true;

    services.lorri.enable = true;
    services.blueman-applet.enable = true;
    services.kdeconnect.enable = true;
    services.kdeconnect.indicator = true;
    # Started with libindicator if `xsession.preferStatusNotifierItems = true`
    services.network-manager-applet.enable = true;

    # Run emacs as a service
    # services.emacs.enable = true;
  })
]
