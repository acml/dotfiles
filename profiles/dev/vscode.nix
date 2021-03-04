{ config, lib, pkgs, ... }:

let
  buildVs = ref:
    pkgs.vscode-utils.buildVscodeMarketplaceExtension {
      mktplcRef = builtins.removeAttrs ref [ "license" ];
      meta = lib.optionalAttrs (ref.license or null != null) { inherit (ref) license; };
    };

  my-vscode-packages = {
    editorconfig = buildVs {
      name = "editorconfig";
      publisher = "editorconfig";
      version = "0.15.1";
      sha256 = "TaovxmPt+PLsdkWDpUgLx+vRE+QRwcCtoAFZFWxLIaM=";
    };
    firefox-dev-tools = buildVs {
      name = "vscode-firefox-debug";
      publisher = "firefox-devtools";
      version = "2.9.1";
      sha256 = "ryAAgXeqwHVYpUVlBTJDxyIXwdakA0ZnVYyKNk36Ifc=";
    };
    nix-env-selector = buildVs {
      name = "nix-env-selector";
      publisher = "arrterian";
      version = "0.1.2";
      sha256 = "aTNxr1saUaN9I82UYCDsQvH9UBWjue/BSnUmMQOnsdg=";
    };
    wakatime = let
      wakatime =
        (buildVs {
          name = "vscode-wakatime";
          publisher = "WakaTime";
          version = "4.0.9";
          sha256 = "YY0LlwFKeQiicNTGS5uifa9+cvr2NlFyKifM9VN2omo=";
        }).overrideAttrs (old: {
          postInstall = old.postInstall or "" + ''
            mkdir -p "$out/${old.installPrefix}/wakatime-cli"
            ln -sT "${pkgs.wakatime}/bin/wakatime" "$out/${old.installPrefix}/wakatime-cli/wakatime-cli"
          '';
        });
    in lib.mkIf config.profiles.dev.wakatime.enable wakatime;
  };

in
{
  my.home = { config, ... }: {

    home.packages = with pkgs; [
      rnix-lsp
    ];

    programs.vscode = {
      enable = true;
      # package = vscodium;

      extensions = with pkgs.vscode-extensions; [
        # bbenoist.Nix
        # coenraads.bracket-pair-colorizer-2
        # donjayamanne.githistory
        eamodio.gitlens
        # esbenp.prettier-vscode
        # file-icons.file-icons
        golang.Go
        # ibm.output-colorizer
        jnoortheen.nix-ide
        # mechatroner.rainbow-csv
        ms-vscode-remote.remote-ssh
        # redhat.vscode-yaml
        vscodevim.vim
        xaver.clang-format
      ]
      ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [
        # ms-vsliveshare.vsliveshare
        # vadimcn.vscode-lldb
        llvm-org.lldb-vscode
        ms-python.python
        ms-vscode.cpptools
      ]
      ++ lib.attrValues my-vscode-packages;

      userSettings = {
        "editor.cursorSmoothCaretAnimation" = true;
        "editor.fontFamily" = "'Source Code Pro', 'Anonymous Pro', 'Droid Sans Mono', 'monospace', monospace, 'Droid Sans Fallback'";
        "editor.fontSize" = 15;
        "editor.rulers" = [ 80 100 120 ];
        "editor.smoothScrolling" = true;
        "editor.stablePeek" = true;
        "explorer.autoReveal" = false;
        "extensions.autoCheckUpdates" = false;
        "git.suggestSmartCommit" = false;
        "search.collapseResults" = "alwaysCollapse";
        "update.channel" = "none";
        "update.mode" = "none";
        "window.menuBarVisibility" = "toggle";
        "window.restoreWindows" = "none";
        "window.title" = "\${activeEditorShort}\${separator}\${rootName}\${separator}\${appName}";
        "workbench.activityBar.visible" = true;
        "workbench.colorTheme" = "Monokai Dimmed";
        "workbench.editor.highlightModifiedTabs" = true;
        "workbench.editor.showTabs" = true;
        "workbench.editor.tabCloseButton" = "off";
        "workbench.editor.untitled.labelFormat" = "name";
        "workbench.iconTheme" = "file-icons";
        "workbench.list.smoothScrolling" = true;

        # Extension settings
        "vscode-neovim.neovimExecutablePaths.linux" = "${config.programs.neovim.finalPackage}";

        # Language settings
        "[nix]"."editor.tabSize" = 2;
        "go.useLanguageServer" = true;
        "gopls"."experimentalWorkspaceModule" = true;
      };

      keybindings = [

      ];
    };
  };
}
