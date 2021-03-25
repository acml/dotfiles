{ config, pkgs, inputs, lib, ... }:

let
  inherit (pkgs.stdenv) isDarwin isLinux;

  enableWakaTime = config.profiles.dev.wakatime.enable;

  # overrides = eself: esuper: rec {
  #   auctex = esuper.auctex.overrideAttrs (old: {
  #     src = pkgs.fetchurl {
  #       # The generated url is wrong, it needs a ".lz"
  #       url = "https://elpa.gnu.org/packages/auctex-${old.version}.tar.lz";
  #       sha256 = old.src.outputHash;
  #     };
  #   });
  #   # elpaPackages.auctex = auctex;
  # };
  overrides = eself: esuper: { };
in
lib.mkMerge [
  {
    environment.variables.EDITOR = "emacsclient -tc";
    environment.variables.ALTERNATE_EDITOR = "emacs";
    environment.shellAliases = {
      vim = "emacsclient -nw";
      e   = "emacsclient -nw";
    };

    nixpkgs.overlays = [ inputs.emacs-overlay.overlay ];

    my.home = lib.mkMerge [
      { imports = [ inputs.doom-emacs.hmModule ]; }
      {
        programs.doom-emacs = {
          enable = true;
          doomPrivateDir = ./doom.d;
          # emacsPackage = pkgs.emacsPgtkGcc;
          emacsPackage = lib.mkMerge [
            (lib.mkIf isLinux pkgs.emacsPgtk)
            (lib.mkIf isDarwin pkgs.emacsPgtk)
          ];
          emacsPackagesOverlay = overrides;
          extraConfig = ''
            (setq ispell-program-name "aspell")
            (setq ispell-dictionary "english")
            ${lib.optionalString isDarwin ''
              (setq insert-directory-program "gls")
            ''}
            ${lib.optionalString enableWakaTime ''
              (global-wakatime-mode t)
              (setq wakatime-cli-path "${pkgs.wakatime}/bin/wakatime")
            ''}
          '';
        };

        programs.zsh.initExtra = builtins.readFile ./emacs-vterm-zsh.sh;

        home.packages = with pkgs; [
          (lib.mkIf isDarwin coreutils-prefixed)
          ## Doom dependencies
          global
          (ripgrep.override { withPCRE2 = true; })

          ## Optional dependencies
          jq # cli to extract data out of json input
          fd # faster projectile indexing
          imagemagick # for image-dired
          nixfmt
          (lib.mkIf (config.programs.gnupg.agent.enable)
            pinentry_emacs) # in-emacs gnupg prompts
          unzip
          zstd # for undo-fu-session/undo-tree compression

          ## Module dependencies
          # :checkers spell
          (aspellWithDicts (dicts: with dicts; [ en en-computers en-science tr ]))
          enchant
          # :checkers grammar
          languagetool
          # :tools editorconfig
          editorconfig-core-c # per-project style config
          # :tools lookup & :lang org +roam
          sqlite
          # :lang cc
          ccls
          (lib.mkIf isLinux glslang)
          # :lang go
          go
          gocode
          gomodifytags
          delve      # vscode
          gopkgs     # vscode
          go-outline # vscode
          golint     # vscode
          golangci-lint
          gopls
          gotests
          gore
          # :lang javascript
          nodePackages.javascript-typescript-langserver
          # :lang lua
          (lib.mkIf isLinux sumneko-lua-language-server)
          # :lang sh
          nodePackages.bash-language-server
          # :lang latex & :lang org (latex previews)
          texlive.combined.scheme-tetex
          # :lang markdown
          pandoc
          # :lang rust
          # (pkgs.latest.rustChannels.stable.rust.override {
          #   extensions = [
          #     "clippy-preview"
          #     # "miri-preview"
          #     "rls-preview"
          #     "rustfmt-preview"
          #     "llvm-tools-preview"
          #     "rust-analysis"
          #     "rust-std"
          #     "rustc-dev"
          #     "rust-src"
          #   ];
          # })
          # :ui treemacs
          python3 # advanced git-mode and directory flattening features require python3
          man-pages
          posix_man_pages
        ];

      }
      # user systemd service for Linux
      (lib.optionalAttrs isLinux {
        services.emacs = {
          enable = true;
          # The client is already provided by the Doom Emacs final package
          client.enable = false;
          socketActivation.enable = true;
        };
      })
    ];
  }
  # Darwin launchd service for Emacs
  (lib.mkIf isDarwin { services.emacs.enable = true; })
]
