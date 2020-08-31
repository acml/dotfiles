{ config, pkgs, inputs, lib, ... }:

let
  inherit (pkgs.stdenv.targetPlatform) isDarwin isLinux system;

  emacs-pgtk-nativecomp = inputs.emacs-pgtk-nativecomp.packages.${system}.emacsGccPgtk;

  # Emacs GTK3 with native JSON and native compilation
  emacs-pgtk = pkgs.emacsPackages.overrideScope' (final: prev: {
    emacs = emacs-pgtk-nativecomp.overrideAttrs (old: {
      configureFlags = old.configureFlags ++ [ "--with-json" ];
      buildInputs = old.buildInputs ++ [ pkgs.jansson ];
    });
  });

  doom-emacs = pkgs.callPackage inputs.doom-emacs {
    doomPrivateDir = ./doom.d;
    emacsPackages = emacs-pgtk;
    # I should pin the dependencies here
    # dependencyOverrides = ;
  };
in
lib.mkMerge [
  {
    home-manager.users.${config.my.username} = lib.mkMerge [
      {
        #home.packages = [ doom-emacs ];
        xdg.configFile."emacs/init.el".text = ''
          (load "default.el")
        '';

        programs.emacs = {
          enable = true;
          package = doom-emacs;
        };
      }
      # user systemd service for Linux
      (lib.mkIf isLinux {
        services.emacs.enable = true;
      })
    ];
  }
  # Darwin launchd service for Emacs
  (lib.mkIf isDarwin { services.emacs.enable = true; })
]
