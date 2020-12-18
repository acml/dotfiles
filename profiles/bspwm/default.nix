{ config, lib, pkgs, ... }:

let
  bspwm = pkgs.symlinkJoin {
    name = "bspwm";
    paths = [ pkgs.bspwm ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/bspwm \
        --prefix PATH : ${lib.makeBinPath (with pkgs; [ polybar networkmanagerapplet ])}
    '';
  };
  # Exposes dmenu sxhkd script
  sxhkd = pkgs.symlinkJoin {
    name = "sxhkd";
    paths = [ pkgs.sxhkd ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/sxhkd \
        --add-flags "-m -1" \
        --prefix PATH : ${lib.makeBinPath [ pkgs.dmenu ]}
    '';
  };
in
{
  services.xserver.windowManager.bspwm = {
    enable = true;
    package = bspwm;
    sxhkd.package = sxhkd;
  };

  my.home = { config, pkgs, ... }: {
    xdg.configFile =
      let
        # sxhkd = "${bspwm_sxhkd}/bin/sxhkd";
        xprop = "${pkgs.xorg.xprop}/bin/xprop";
        xwininfo = "${pkgs.xorg.xwininfo}/bin/xwininfo";
      in {
        "bspwm/bspwmrc" = {
          executable = true;
          source = pkgs.substituteAll {
            name = "bspwm-config";
            src = ./bspwmrc.in;
            # inherit (pkgs) alacritty zsh tmux dmenu fzf findutils;
            inherit sxhkd;
          };
        };
        "bspwm/bspwm_external_rules".source = pkgs.substituteAll {
          name = "bspwm-external-rules";
          src = ./bspwm_external_rules.in;
          inherit xprop xwininfo;
        };
        "polybar/config".source = pkgs.substituteAll rec {
          name = "polybar-config";
          src = ./polybarrc.in;
        };
        "sxhkd/sxhkdrc".source = pkgs.substituteAll rec {
          name = "sxhkd-config";
          src = ./sxhkdrc.in;
        };
      };
    home.packages = with pkgs; [
    ];
  };
}
